# syntax=docker/dockerfile:1

FROM dunglas/frankenphp:1-php8.5 AS frankenphp_prod

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

ARG MONITORING_BUNDLE_REPOSITORY
ARG MONITORING_BUNDLE_REF=develop

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && install-php-extensions @composer intl opcache \
    && rm -rf /var/lib/apt/lists/* \
    && test -n "$MONITORING_BUNDLE_REPOSITORY" \
    && git clone --depth 1 --branch "$MONITORING_BUNDLE_REF" "$MONITORING_BUNDLE_REPOSITORY" /monitoring-bundle

ENV APP_ENV=prod
ENV APP_DEBUG=0
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PHP_INI_SCAN_DIR=":$PHP_INI_DIR/app.conf.d"

COPY composer.json composer.lock ./

# The local development repository is kept in composer.json for the demo;
# production copies the cloned bundle into vendor instead of creating a symlink.
RUN sed -i 's/"symlink": true/"symlink": false/' composer.json \
    && composer install --no-dev --prefer-dist --no-progress --no-interaction --optimize-autoloader --no-scripts

COPY config config
COPY bin bin
COPY public public
COPY src src

RUN mkdir -p var/cache var/log \
    && composer dump-autoload --classmap-authoritative --no-dev \
    && php bin/console cache:clear --no-warmup --no-interaction \
    && chown -R www-data:www-data /app

COPY frankenphp/Caddyfile /etc/frankenphp/Caddyfile
COPY frankenphp/conf.d/10-app.ini $PHP_INI_DIR/app.conf.d/10-app.ini
COPY --chmod=755 frankenphp/docker-entrypoint.sh /usr/local/bin/docker-entrypoint

USER www-data

ENTRYPOINT ["docker-entrypoint"]
HEALTHCHECK --start-period=30s CMD php -r 'exit(false === @file_get_contents("http://localhost:2019/metrics", context: stream_context_create(["http" => ["timeout" => 5]])) ? 1 : 0);'
CMD ["frankenphp", "run", "--config", "/etc/frankenphp/Caddyfile"]
