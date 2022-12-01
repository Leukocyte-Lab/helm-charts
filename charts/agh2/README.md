# AGH2

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
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `["lkc-registry"]`     |
| `global.storageClass`     | Global storage class for dynamic provisioning   | `""`                   |


### Common parameters

| Name                                 | Description                                       | Value                  |
| ------------------------------------ | ------------------------------------------------- | ---------------------- |
| `customRegistrySecret.enabled`       | Enable custom registry secret generation          | `true`                 |
| `customRegistrySecret.secretName`    | Name of the generated secret                      | `lkc-registry`         |
| `customRegistrySecret.auth.registry` | URL of the registry server                        | `registry.lkc-lab.com` |
| `customRegistrySecret.auth.username` | Username to authenticate with the registry server | `""`                   |
| `customRegistrySecret.auth.password` | Password to authenticate with the registry server | `""`                   |


### Database parameters

| Name                               | Description                              | Value                  |
| ---------------------------------- | ---------------------------------------- | ---------------------- |
| `db.connection.type`               | Choose to use external DB or internal DB | `external`             |
| `db.connection.driver`             | Database driver                          | `postgresql`           |
| `db.connection.host`               | Database host address                    | `database.example.com` |
| `db.connection.port`               | Database host port                       | `5432`                 |
| `db.connection.user`               | Database user                            | `argushack`            |
| `db.connection.password`           | Database password                        | `""`                   |
| `db.connection.options`            | Database connection options              |                        |
| `db.connection.options.disableSSL` | Disable SSL connection                   | `true`                 |


### Internal database provisioning parameters

Leave as default if using external DB

| Name                   | Description                                                  | Value                 |
| ---------------------- | ------------------------------------------------------------ | --------------------- |
| `db.internal.enabled`  | Enable internal database                                     | `false`               |
| `db.image.repository`  | Internal database image repository                           | `bitnami/postgresql`  |
| `db.image.tag`         | Internal database image tag (immutable tags are recommended) | `15.1.0-debian-11-r0` |
| `db.image.pullPolicy`  | Internal database image pull policy                          | `IfNotPresent`        |
| `db.image.pullSecrets` | Specify docker-registry secret names as an array             | `[]`                  |


### Minio parameters

| Name                        | Description                              | Value                  |
| --------------------------- | ---------------------------------------- | ---------------------- |
| `minio.connection.type`     | Choose to use external DB or internal DB | `external`             |
| `minio.connection.host`     | Database host address                    | `database.example.com` |
| `minio.connection.port`     | Database host port                       | `5432`                 |
| `minio.connection.user`     | Database user                            | `argushack`            |
| `minio.connection.password` | Database password                        | `""`                   |


### Internal minio provisioning parameters

Leave as default if using external DB

| Name                      | Description                                               | Value                     |
| ------------------------- | --------------------------------------------------------- | ------------------------- |
| `minio.internal.enabled`  | Enable internal minio                                     | `false`                   |
| `minio.image.repository`  | Internal Minio image repository                           | `bitnami/minio`           |
| `minio.image.tag`         | Internal Minio image tag (immutable tags are recommended) | `2022.11.29-debian-11-r0` |
| `minio.image.pullPolicy`  | Internal Minio image pull policy                          | `IfNotPresent`            |
| `minio.image.pullSecrets` | Specify docker-registry secret names as an array          | `[]`                      |


### Redis parameters

| Name                      | Description                                      | Value                  |
| ------------------------- | ------------------------------------------------ | ---------------------- |
| `redis.enabled`           | Enable redis                                     | `true`                 |
| `redis.image.repository`  | Redis image repository                           | `docker/library/redis` |
| `redis.image.tag`         | Redis image tag (immutable tags are recommended) | `6-alpine`             |
| `redis.image.pullPolicy`  | Redis image pull policy                          | `IfNotPresent`         |
| `redis.image.pullSecrets` | Specify docker-registry secret names as an array | `[]`                   |


### AGH2-ATTACK parameters

ATTACK module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-ATTACK

| Name                                    | Description                                                    | Value                                      |
| --------------------------------------- | -------------------------------------------------------------- | ------------------------------------------ |
| `attack.enabled`                        | Enable ATTACK module                                           | `true`                                     |
| `attack.image.repository`               | ATTACK image repository                                        | `leukocyte-lab/argushack2/attack`          |
| `attack.image.tag`                      | ATTACK image tag (immutable tags are recommended)              | `v0.9.0`                                   |
| `attack.image.pullPolicy`               | ATTACK image pull policy                                       | `IfNotPresent`                             |
| `attack.image.pullSecrets`              | Specify docker-registry secret names as an array               | `[]`                                       |
| `attack.secret.enabled`                 | Enable secret generate for ATTACK                              | `true`                                     |
| `attack.secret.db.enabled`              | Enable secret generate for DB                                  | `true`                                     |
| `attack.secret.db.secretName`           | Secret name for Captain DB                                     | `attack-db-secret`                         |
| `attack.secret.db.name`                 | Database name                                                  | `attack-db`                                |
| `attack.secret.db.user`                 | Database user                                                  | `""`                                       |
| `attack.secret.db.password`             | Database password                                              | `""`                                       |
| `attack.service`                        | ATTACK service parameters                                      |                                            |
| `attack.service.group.enabled`          | Enable ATTACK Group worker                                     | `true`                                     |
| `attack.service.group.image.repository` | ATTACK Group worker image repository                           | `leukocyte-lab/argushack2/group`           |
| `attack.service.group.image.tag`        | ATTACK Group worker image tag (immutable tags are recommended) | `v1.3.6`                                   |
| `attack.service.ui.enabled`             | Enable ATTACK UI                                               | `true`                                     |
| `attack.service.ui.image.repository`    | ATTACK UI image repository                                     | `leukocyte-lab/argushack2/attack-frontend` |
| `attack.service.ui.image.tag`           | ATTACK UI image tag (immutable tags are recommended)           | `v0.3.0`                                   |
| `attack.service.ui.image.pullPolicy`    | ATTACK UI image pull policy                                    | `IfNotPresent`                             |
| `attack.service.ui.image.pullSecrets`   | Specify docker-registry secret names as an array               | `[]`                                       |
| `attack.service.redis.enabled`          | Enable redis                                                   | `true`                                     |
| `attack.extraEnv`                       | ATTACK additional environment variables                        | `{}`                                       |


### AGH2-Blender parameters

Blender module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Blender

| Name                            | Description                                        | Value                              |
| ------------------------------- | -------------------------------------------------- | ---------------------------------- |
| `blender.enabled`               | Enable Blender module                              | `true`                             |
| `blender.image.repository`      | Blender image repository                           | `leukocyte-lab/argushack2/blender` |
| `blender.image.tag`             | Blender image tag (immutable tags are recommended) | `v1.1.0`                           |
| `blender.image.pullPolicy`      | Blender image pull policy                          | `IfNotPresent`                     |
| `blender.image.pullSecrets`     | Specify docker-registry secret names as an array   | `[]`                               |
| `blender.service`               | ATTACK service parameters                          |                                    |
| `blender.service.redis.enabled` | Enable redis                                       | `true`                             |
| `blender.extraEnv`              | Captain additional environment variables           | `{}`                               |


### AGH2-Captain parameters

Captain module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Captain

| Name                               | Description                                        | Value                              |
| ---------------------------------- | -------------------------------------------------- | ---------------------------------- |
| `captain.enabled`                  | Enable Captain module                              | `true`                             |
| `captain.image.repository`         | Captain image repository                           | `leukocyte-lab/argushack2/captain` |
| `captain.image.tag`                | Captain image tag (immutable tags are recommended) | `v0.19.0`                          |
| `captain.image.pullPolicy`         | Captain image pull policy                          | `IfNotPresent`                     |
| `captain.image.pullSecrets`        | Specify docker-registry secret names as an array   | `[]`                               |
| `captain.secret.enabled`           | Enable secret generate for Captain                 | `true`                             |
| `captain.secret.db.enabled`        | Enable secret generate for Captain database        | `true`                             |
| `captain.secret.db.secretName`     | Secret name for Captain DB                         | `capt-db-secret`                   |
| `captain.secret.db.name`           | Database name                                      | `captain-db`                       |
| `captain.secret.db.user`           | Database user                                      | `""`                               |
| `captain.secret.db.password`       | Database password                                  | `""`                               |
| `captain.secret.minio.enabled`     | Enable secret generate for Minio                   | `true`                             |
| `captain.secret.minio.secretName`  | Secret name for Minio                              | `capt-minio-secret`                |
| `captain.secret.minio.user`        | Minio user                                         | `capt-minio-user`                  |
| `captain.secret.minio.password`    | Minio password                                     | `""`                               |
| `captain.secret.keygen.enabled`    | Enable secret generate for keygen                  | `true`                             |
| `captain.secret.keygen.secretName` | Secret name for keygen                             | `capt-keygen-secret`               |
| `captain.secret.keygen.apiToken`   | Keygen API Token                                   | `""`                               |
| `captain.secret.keygen.accountID`  | Keygen Account ID                                  | `""`                               |
| `captain.secret.jwt.enabled`       | Enable secret generate for JWT                     | `true`                             |
| `captain.secret.jwt.secretName`    | Secret name for JWT                                | `capt-jwt-secret`                  |
| `captain.secret.jwt.secret`        | JWT secret                                         | `""`                               |
| `captain.service`                  | Captain service parameters                         |                                    |
| `captain.service.redis.enabled`    | Enable redis                                       | `true`                             |
| `captain.extraEnv`                 | Captain additional environment variables           | `{}`                               |


### AGH2-Core parameters

Core module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Core

| Name                           | Description                                      | Value                           |
| ------------------------------ | ------------------------------------------------ | ------------------------------- |
| `core.enabled`                 | Enable Core module                               | `true`                          |
| `core.image.repository`        | Core image repository                            | `leukocyte-lab/argushack2/core` |
| `core.image.tag`               | Core image tag (immutable tags are recommended)  | `v1.16.2`                       |
| `core.image.pullPolicy`        | Core image pull policy                           | `IfNotPresent`                  |
| `core.image.pullSecrets`       | Specify docker-registry secret names as an array | `[]`                            |
| `core.secret.enabled`          | Enable secret generate for Core                  | `true`                          |
| `core.secret.db.enabled`       | Enable secret generate for Core database         | `true`                          |
| `core.secret.db.secretName`    | Secret name for Core DB                          | `core-db-secret`                |
| `core.secret.db.name`          | Database name                                    | `core-db`                       |
| `core.secret.db.user`          | Database user                                    | `""`                            |
| `core.secret.db.password`      | Database password                                | `""`                            |
| `core.secret.minio.enabled`    | Enable secret generate for Minio                 | `true`                          |
| `core.secret.minio.secretName` | Secret name for Minio                            | `core-minio-secret`             |
| `core.secret.minio.user`       | Minio user                                       | `core-minio-user`               |
| `core.secret.minio.password`   | Minio password                                   | `""`                            |
| `core.service`                 | Core service parameters                          |                                 |
| `core.service.redis.enabled`   | Enable redis                                     | `true`                          |
| `core.env`                     | Core environment variables                       |                                 |
| `core.env.REGISTRY_URL`        | Core registry URL                                | `https://registry.lkc-lab.com`  |
| `core.extraEnv`                | Core additional environment variables            | `{}`                            |


### AGH2-Exploit-Manager parameters

Exploit-Manager module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Exploit-Manager

| Name                                 | Description                                                | Value                                 |
| ------------------------------------ | ---------------------------------------------------------- | ------------------------------------- |
| `exploitmgr.enabled`                 | Enable Exploit-Manager module                              | `true`                                |
| `exploitmgr.image.repository`        | Exploit-Manager image repository                           | `leukocyte-lab/argushack2/exploitmgr` |
| `exploitmgr.image.tag`               | Exploit-Manager image tag (immutable tags are recommended) | `v0.11.1`                             |
| `exploitmgr.image.pullPolicy`        | Exploit-Manager image pull policy                          | `IfNotPresent`                        |
| `exploitmgr.image.pullSecrets`       | Specify docker-registry secret names as an array           | `[]`                                  |
| `exploitmgr.secret.enabled`          | Enable secret generate for Exploit-Manager                 | `true`                                |
| `exploitmgr.secret.db.enabled`       | Enable secret generate for Exploit-Manager database        | `true`                                |
| `exploitmgr.secret.db.secretName`    | Secret name for Exploit-Manager DB                         | `exploitmgr-db-secret`                |
| `exploitmgr.secret.db.name`          | Database name                                              | `exploitmgr-db`                       |
| `exploitmgr.secret.db.user`          | Database user                                              | `""`                                  |
| `exploitmgr.secret.db.password`      | Database password                                          | `""`                                  |
| `exploitmgr.secret.minio.enabled`    | Enable secret generate for Minio                           | `true`                                |
| `exploitmgr.secret.minio.secretName` | Secret name for Minio                                      | `exploitmgr-minio-secret`             |
| `exploitmgr.secret.minio.user`       | Minio user                                                 | `""`                                  |
| `exploitmgr.secret.minio.password`   | Minio password                                             | `""`                                  |
| `exploitmgr.service`                 | Exploit-Manager service parameters                         |                                       |
| `exploitmgr.service.redis.enabled`   | Enable redis                                               | `true`                                |
| `exploitmgr.env`                     | Exploit-Manager environment variables                      |                                       |
| `exploitmgr.env.REGISTRY_URL`        | Exploit-Manager registry URL                               | `https://registry.lkc-lab.com`        |
| `exploitmgr.extraEnv`                | Exploit-Manager additional environment variables           | `{}`                                  |


### AGH2-Matcher parameters

Matcher module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Matcher

| Name                        | Description                                        | Value                              |
| --------------------------- | -------------------------------------------------- | ---------------------------------- |
| `matcher.enabled`           | Enable Matcher module                              | `true`                             |
| `matcher.image.repository`  | Matcher image repository                           | `leukocyte-lab/argushack2/matcher` |
| `matcher.image.tag`         | Matcher image tag (immutable tags are recommended) | `v1.2.2`                           |
| `matcher.image.pullPolicy`  | Matcher image pull policy                          | `IfNotPresent`                     |
| `matcher.image.pullSecrets` | Specify docker-registry secret names as an array   | `[]`                               |
| `matcher.extraEnv`          | Captain additional environment variables           | `{}`                               |


### AGH2-Transformer parameters

Transformer module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Transformer

| Name                            | Description                                            | Value                                  |
| ------------------------------- | ------------------------------------------------------ | -------------------------------------- |
| `transformer.enabled`           | Enable Transformer module                              | `true`                                 |
| `transformer.image.repository`  | Transformer image repository                           | `leukocyte-lab/argushack2/transformer` |
| `transformer.image.tag`         | Transformer image tag (immutable tags are recommended) | `v1.1.0`                               |
| `transformer.image.pullPolicy`  | Transformer image pull policy                          | `IfNotPresent`                         |
| `transformer.image.pullSecrets` | Specify docker-registry secret names as an array       | `[]`                                   |
| `transformer.extraEnv`          | Captain additional environment variables               | `{}`                                   |

