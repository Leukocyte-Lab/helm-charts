# AGH2-helm

## Install

```bash
helm repo add lkclab https://charts.lkc-lab.com/
helm repo update

helm install agh2 lkclab/agh2
```

## Parameters

### Global parameters

| Name                      | Description                                     | Value                  |
| ------------------------- | ----------------------------------------------- | ---------------------- |
| `global.imageRegistry`    | Global Docker Image registry                    | `registry.lkc-lab.com` |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`                   |
| `global.storageClass`     | Global storage class for dynamic provisioning   | `""`                   |


### Database parameters

| Name                               | Description                              | Value                  |
| ---------------------------------- | ---------------------------------------- | ---------------------- |
| `db.connection`                    | Connection information for the database  |                        |
| `db.connection.type`               | Choose to use external DB or internal DB | `external`             |
| `db.connection.host`               | Database host address                    | `database.example.com` |
| `db.connection.port`               | Database host port                       | `5432`                 |
| `db.connection.user`               | Database user                            | `argushack`            |
| `db.connection.password`           | Database password                        | `""`                   |
| `db.connection.options`            | Database connection options              |                        |
| `db.connection.options.disableSSL` | Disable SSL connection                   | `true`                 |


### Internal database provisioning parameters

Leave as default if using external DB

| Name                           | Description                                                  | Value                 |
| ------------------------------ | ------------------------------------------------------------ | --------------------- |
| `db.internal.enabled`          | Enable internal database                                     | `false`               |
| `db.internal.image.repository` | Internal database image repository                           | `bitnami/postgresql`  |
| `db.internal.image.tag`        | Internal database image tag (immutable tags are recommended) | `15.1.0-debian-11-r0` |
| `db.internal.image.pullPolicy` | Internal database image pull policy                          | `IfNotPresent`        |


### Redis parameters

| Name                     | Description                                      | Value                  |
| ------------------------ | ------------------------------------------------ | ---------------------- |
| `redis.enabled`          | Enable redis                                     | `true`                 |
| `redis.image.repository` | Redis image repository                           | `docker/library/redis` |
| `redis.image.tag`        | Redis image tag (immutable tags are recommended) | `6-alpine`             |
| `redis.image.pullPolicy` | Redis image pull policy                          | `IfNotPresent`         |


### AGH2-ATTACK parameters

ATTACK module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-ATTACK

| Name                                    | Description                                                    | Value                                                           |
| --------------------------------------- | -------------------------------------------------------------- | --------------------------------------------------------------- |
| `attack.enabled`                        | Enable ATTACK module                                           | `true`                                                          |
| `attack.image.repository`               | ATTACK image repository                                        | `registry.lkc-lab.com/leukocyte-lab/argushack2/attack`          |
| `attack.image.tag`                      | ATTACK image tag (immutable tags are recommended)              | `v0.9.0`                                                        |
| `attack.image.pullPolicy`               | ATTACK image pull policy                                       | `IfNotPresent`                                                  |
| `attack.secret.enabled`                 | Enable secret generate for ATTACK                              | `true`                                                          |
| `attack.secret.name`                    | Secret name for ATTACK                                         | `attack-db-secret`                                              |
| `attack.secret.db.name`                 | Database name                                                  | `attack-db`                                                     |
| `attack.secret.db.user`                 | Database user                                                  | `""`                                                            |
| `attack.secret.db.password`             | Database password                                              | `""`                                                            |
| `attack.service`                        | ATTACK service parameters                                      |                                                                 |
| `attack.service.group.image.repository` | ATTACK Group worker image repository                           | `registry.lkc-lab.com/leukocyte-lab/argushack2/group`           |
| `attack.service.group.image.tag`        | ATTACK Group worker image tag (immutable tags are recommended) | `v1.3.6`                                                        |
| `attack.service.ui.image.repository`    | ATTACK UI image repository                                     | `registry.lkc-lab.com/leukocyte-lab/argushack2/attack-frontend` |
| `attack.service.ui.image.tag`           | ATTACK UI image tag (immutable tags are recommended)           | `v0.3.0`                                                        |
| `attack.service.ui.image.pullPolicy`    | ATTACK UI image pull policy                                    | `IfNotPresent`                                                  |
| `attack.extraEnv`                       | ATTACK additional environment variables                        | `{}`                                                            |

