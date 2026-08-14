#!/bin/sh
set -eu

if [ "$1" = "frankenphp" ]; then
    php bin/console cache:warmup --no-interaction
fi

exec docker-php-entrypoint "$@"
