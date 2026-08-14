# Déploiement VPS

La stack utilise une image FrankenPHP construite par la CI puis publiée dans
GHCR. Le build clone le bundle Composer depuis `MONITORING_BUNDLE_REPOSITORY`.

## Variables GitHub

Variable de repository :

```text
MONITORING_BUNDLE_REPOSITORY=https://.../monitoring-bundle.git
```

Secrets de l’environnement `production` :

```text
DEPLOY_HOST
DEPLOY_PORT
DEPLOY_USER
DEPLOY_PATH
DEPLOY_SSH_KEY
DEPLOY_KNOWN_HOSTS
```

Le fichier `.env` de production doit être provisionné directement sur le VPS
avec `APP_SECRET`, les tokens monitoring et `SERVER_NAME`. Il ne doit jamais
être committé.

## Déploiement manuel

```bash
docker compose -f compose.prod.yaml \
  --env-file .env.prod.local \
  pull

docker compose -f compose.prod.yaml \
  --env-file .env.prod.local \
  up -d --remove-orphans --wait
```
