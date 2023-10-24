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
| `customRegistrySecret.auth.registry` | URL of the registry server                        | `registry.lkc-lab.com` |
| `customRegistrySecret.auth.username` | Username to authenticate with the registry server | `""`                   |
| `customRegistrySecret.auth.password` | Password to authenticate with the registry server | `""`                   |


### Keygen parameters

| Name                | Description                       | Value               |
| ------------------- | --------------------------------- | ------------------- |
| `keygen.enabled`    | Enable secret generate for keygen | `true`              |
| `keygen.secretName` | Secret name for keygen            | `keygen-secret`     |
| `keygen.apiToken`   | Keygen API Token                  | `""`                |
| `keygen.accountID`  | Keygen Account ID                 | `""`                |
| `ingress.enabled`   | Enable ingress controller         | `true`              |
| `ingress.host`      | Ingress hostname                  | `app.argushack.com` |


### TLS parameters

| Name                     | Description                       | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------------ | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `ingress.tls.enabled`    | Enable TLS certificate generation | `false`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `ingress.tls.secretName` | Name of the generated secret      | `agh-tls`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `ingress.tls.cert`       | Server certificate content        | `LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUUwakNDQkhpZ0F3SUJBZ0lSQU5jRVNiK2E0M0NQeE85Sm9rWVdUcWt3Q2dZSUtvWkl6ajBFQXdJd2dZOHgKQ3pBSkJnTlZCQVlUQWtkQ01Sc3dHUVlEVlFRSUV4SkhjbVZoZEdWeUlFMWhibU5vWlhOMFpYSXhFREFPQmdOVgpCQWNUQjFOaGJHWnZjbVF4R0RBV0JnTlZCQW9URDFObFkzUnBaMjhnVEdsdGFYUmxaREUzTURVR0ExVUVBeE11ClUyVmpkR2xuYnlCRlEwTWdSRzl0WVdsdUlGWmhiR2xrWVhScGIyNGdVMlZqZFhKbElGTmxjblpsY2lCRFFUQWUKRncweU1qQTFNVEV3TURBd01EQmFGdzB5TXpBME1URXlNelU1TlRsYU1Cd3hHakFZQmdOVkJBTVRFV0Z3Y0M1aApjbWQxYzJoaFkyc3VZMjl0TUhZd0VBWUhLb1pJemowQ0FRWUZLNEVFQUNJRFlnQUUwR0N3LzRkeHR1Y1U5Z0hXCmorc2xCcHlvVDY1MHF6b2s2bVhxbUIwL3IxbGtqVE1ydVkvbnhyd2p4ZXFYZTlZejJtSkVjazBFZTdYcWV4Y2YKL0FPVXg0bUlrQmJyTTZUZHp3UVJtcUxabUl1SjFEYWI3bkk0UXNwdXZ2U3RQV3dmbzRJRENEQ0NBd1F3SHdZRApWUjBqQkJnd0ZvQVU5b1VLT3hHRzRRUjlEcW9MTE5MdXpHUjdlNjR3SFFZRFZSME9CQllFRkJVUDh1RHZaK042Ci9qUFJsa2hzZWFQMDRLeVlNQTRHQTFVZER3RUIvd1FFQXdJSGdEQU1CZ05WSFJNQkFmOEVBakFBTUIwR0ExVWQKSlFRV01CUUdDQ3NHQVFVRkJ3TUJCZ2dyQmdFRkJRY0RBakJKQmdOVkhTQUVRakJBTURRR0N5c0dBUVFCc2pFQgpBZ0lITUNVd0l3WUlLd1lCQlFVSEFnRVdGMmgwZEhCek9pOHZjMlZqZEdsbmJ5NWpiMjB2UTFCVE1BZ0dCbWVCCkRBRUNBVENCaEFZSUt3WUJCUVVIQVFFRWVEQjJNRThHQ0NzR0FRVUZCekFDaGtOb2RIUndPaTh2WTNKMExuTmwKWTNScFoyOHVZMjl0TDFObFkzUnBaMjlGUTBORWIyMWhhVzVXWVd4cFpHRjBhVzl1VTJWamRYSmxVMlZ5ZG1WeQpRMEV1WTNKME1DTUdDQ3NHQVFVRkJ6QUJoaGRvZEhSd09pOHZiMk56Y0M1elpXTjBhV2R2TG1OdmJUQXpCZ05WCkhSRUVMREFxZ2hGaGNIQXVZWEpuZFhOb1lXTnJMbU52YllJVmQzZDNMbUZ3Y0M1aGNtZDFjMmhoWTJzdVkyOXQKTUlJQmZBWUtLd1lCQkFIV2VRSUVBZ1NDQVd3RWdnRm9BV1lBZFFDdDk3NzZmUDhReUl1ZFBad2VQaGhxdEdjcApYYyt4RENUS2hZWTA2OXlDaWdBQUFZQ3lYcUdRQUFBRUF3QkdNRVFDSUgwK3g4ZFR6YXEvaUJaeUU3L2pBSW5lCjJnSGhyT0tiYjBvZnZnMkYzKzhuQWlCaVZIZFV6cWZVL21vR0RyNEJLZk9BbWM0MHJWc0plSHZWWFVycjYrcGEKVUFCMUFIb3lqRlRZdHkyMklPbzQ0RkllNllRV2NESVRoVTA3MGl2Qk9sZWpVdXRTQUFBQmdMSmVvYmdBQUFRRApBRVl3UkFJZ085czRoV1U5cTZTZXBKZ0d5L21CN2xjejBqUmFBVVRtcmdocnhYYXgvZkFDSUJzSnNHeDJkaTExCnV6SEhxbUNUMXpBNUdkem9QTnlQbGxTK3hqWEl5WEpuQUhZQTZEN1EyajcxQmpVeTUxY292SWxyeVFQVHk5RVIKYSt6cmFlRjNmVzBHdlc0QUFBR0FzbDZoY2dBQUJBTUFSekJGQWlCb1FwT1BvUjVuWEpDMW95VjJseDRqK2hCagpxSnRjVW5sRll6d1lOSklDS0FJaEFMdDVTUjlXNGpKbitlNjhINEl4eU9ab1Evd2RlZEVaNVNUYUpzUHA3dDdKCk1Bb0dDQ3FHU000OUJBTUNBMGdBTUVVQ0lRRGNwQ0RqZjdwSEN4ekxNNW5XclpqQzMxS1MzanB5eVFreXNnbFEKZng0cG9BSWdKZE5qR2hsYkZqaHRWTFRCK1cyNkFNRVMveUMxSFZjeTh6STY4RWwzREdnPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0t` |
| `ingress.tls.key`        | Server private key content        | `""`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |


### Database parameters

| Name                               | Description                              | Value                  |
| ---------------------------------- | ---------------------------------------- | ---------------------- |
| `db.connection.type`               | Choose to use external DB or internal DB | `internal`             |
| `db.connection.driver`             | Database driver                          | `postgresql`           |
| `db.connection.host`               | Database host address                    | `database.example.com` |
| `db.connection.port`               | Database host port                       | `5432`                 |
| `db.connection.user`               | Database user                            | `argushack`            |
| `db.connection.password`           | Database password                        | `""`                   |
| `db.connection.options`            | Database connection options              |                        |
| `db.connection.options.disableSSL` | Disable SSL connection                   | `true`                 |
| `db.internal.enabled`              | Enable internal database                 | `true`                 |


### Helper parameters

Control the DB Helper behaviors.

| Name                                            | Description                    | Value  |
| ----------------------------------------------- | ------------------------------ | ------ |
| `db.helpers.init.dbs.enabled`                   | Enable dbs init feature        | `true` |
| `db.helpers.init.dbs.installPgroongaExtensions` | Install pgroonga extensions    | `true` |
| `db.helpers.init.attack.enabled`                | Enable attack-datasets feature | `true` |


### Internal PostgreSQL database provisioning parameters

Leave as default if using external DB

| Name                                         | Description                                                   | Value                                           |
| -------------------------------------------- | ------------------------------------------------------------- | ----------------------------------------------- |
| `postgresql.enabled`                         | Enable internal database                                      | `true`                                          |
| `postgresql.image.repository`                | Internal database image repository                            | `leukocyte-lab/postgresql`                      |
| `postgresql.image.tag`                       | Internal database image tag (immutable tags are recommended)  | `v0.1.2-postgres-15.1.0-pgroonga-2.4.2-debian`  |
| `postgresql.image.pullPolicy`                | Internal database image pull policy                           | `IfNotPresent`                                  |
| `postgresql.image.pullSecrets`               | Specify docker-registry secret names as an array              | `[]`                                            |
| `postgresql.auth.enabled`                    | Enable postgresql auth secret generate                        | `true`                                          |
| `postgresql.auth.username`                   | Internal database initial user                                | `argushack`                                     |
| `postgresql.auth.password`                   | Internal database initial password                            | `""`                                            |
| `postgresql.auth.postgresPassword`           | Internal database initial postgres admin password             | `""`                                            |
| `postgresql.primary.extendedConfiguration`   | Extended configuration for the primary node                   | `max_connections = 32768
shared_buffers = 4GB
` |
| `postgresql.primary.initdb.enabled`          | Enable initdb scripts generation                              | `true`                                          |
| `postgresql.primary.initdb.scriptsConfigMap` | Name of ConfigMap containing db-init scripts                  | `db-init-scripts`                               |
| `postgresql.primary.initdb.user`             | Specify the PostgreSQL username to execute the initdb scripts | `argushack`                                     |
| `postgresql.primary.initdb.password`         | Specify the PostgreSQL password to execute the initdb scripts | `""`                                            |


### Minio parameters

| Name                        | Description                              | Value                  |
| --------------------------- | ---------------------------------------- | ---------------------- |
| `minio.connection.type`     | Choose to use external DB or internal DB | `internal`             |
| `minio.connection.host`     | Database host address                    | `database.example.com` |
| `minio.connection.port`     | Database host port                       | `9000`                 |
| `minio.connection.user`     | Database user                            | `argushack`            |
| `minio.connection.password` | Database password                        | `""`                   |
| `minio.secret.enabled`      | Enable minio secret generation           | `true`                 |
| `minio.secret.secretName`   | Name of the generated secret             | `minio-secret`         |


### Internal minio provisioning parameters

Leave as default if using external DB

| Name                              | Description                                               | Value                         |
| --------------------------------- | --------------------------------------------------------- | ----------------------------- |
| `minio.internal.enabled`          | Enable internal minio                                     | `true`                        |
| `minio.image.repository`          | Internal MinIO image repository                           | `docker/bitnami/minio`        |
| `minio.image.tag`                 | Internal MinIO image tag (immutable tags are recommended) | `2023.3.24`                   |
| `minio.image.pullPolicy`          | Internal MinIO image pull policy                          | `IfNotPresent`                |
| `minio.image.pullSecrets`         | Specify docker-registry secret names as an array          | `[]`                          |
| `minio.clientImage.repository`    | Internal MinIO image repository                           | `docker/bitnami/minio-client` |
| `minio.clientImage.tag`           | Internal MinIO image tag (immutable tags are recommended) | `2023.4.12`                   |
| `minio.clientImage.pullPolicy`    | Internal MinIO image pull policy                          | `IfNotPresent`                |
| `minio.clientImage.pullSecrets`   | Specify docker-registry secret names as an array          | `[]`                          |
| `minio.auth.rootUser`             | Internal database root user                               | `argushack`                   |
| `minio.auth.rootPassword`         | Internal database root password                           | `""`                          |
| `minio.provisioning.enabled`      | Enable minio provisioning                                 | `true`                        |
| `minio.provisioning.generateUser` | Enable minio user generation                              | `true`                        |


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
| `attack.image.tag`                      | ATTACK image tag (immutable tags are recommended)              | `v0.12.0`                                  |
| `attack.image.pullPolicy`               | ATTACK image pull policy                                       | `IfNotPresent`                             |
| `attack.image.pullSecrets`              | Specify docker-registry secret names as an array               | `[]`                                       |
| `attack.secret.enabled`                 | Enable secret generate for ATTACK                              | `true`                                     |
| `attack.secret.db.enabled`              | Enable secret generate for DB                                  | `true`                                     |
| `attack.secret.db.name`                 | Database name                                                  | `attack-db`                                |
| `attack.secret.db.user`                 | Database user                                                  | `agh-attack`                               |
| `attack.secret.db.password`             | Database password                                              | `""`                                       |
| `attack.service`                        | ATTACK service parameters                                      |                                            |
| `attack.service.group.enabled`          | Enable ATTACK Group worker                                     | `true`                                     |
| `attack.service.group.image.repository` | ATTACK Group worker image repository                           | `leukocyte-lab/argushack2/group`           |
| `attack.service.group.image.tag`        | ATTACK Group worker image tag (immutable tags are recommended) | `v1.6.2`                                   |
| `attack.service.ui.enabled`             | Enable ATTACK UI                                               | `true`                                     |
| `attack.service.ui.image.repository`    | ATTACK UI image repository                                     | `leukocyte-lab/argushack2/attack-frontend` |
| `attack.service.ui.image.tag`           | ATTACK UI image tag (immutable tags are recommended)           | `v0.3.2-rc.0`                              |
| `attack.service.ui.image.pullPolicy`    | ATTACK UI image pull policy                                    | `IfNotPresent`                             |
| `attack.service.ui.image.pullSecrets`   | Specify docker-registry secret names as an array               | `[]`                                       |
| `attack.service.redis.enabled`          | Enable redis                                                   | `true`                                     |
| `attack.extraEnv`                       | ATTACK additional environment variables                        | `{}`                                       |


### AGH2-Blender parameters

Blender module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Blender

| Name                            | Description                                        | Value                              |
| ------------------------------- | -------------------------------------------------- | ---------------------------------- |
| `blender.enabled`               | Enable Blender module                              | `false`                            |
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

| Name                                              | Description                                               | Value                                     |
| ------------------------------------------------- | --------------------------------------------------------- | ----------------------------------------- |
| `captain.enabled`                                 | Enable Captain module                                     | `true`                                    |
| `captain.image.repository`                        | Captain image repository                                  | `leukocyte-lab/argushack2/captain`        |
| `captain.image.tag`                               | Captain image tag (immutable tags are recommended)        | `v0.23.0`                                 |
| `captain.image.pullPolicy`                        | Captain image pull policy                                 | `IfNotPresent`                            |
| `captain.image.pullSecrets`                       | Specify docker-registry secret names as an array          | `[]`                                      |
| `captain.secret.enabled`                          | Enable secret generate for Captain                        | `true`                                    |
| `captain.secret.db.enabled`                       | Enable secret generate for Captain database               | `true`                                    |
| `captain.secret.db.name`                          | Database name                                             | `captain-db`                              |
| `captain.secret.db.user`                          | Database user                                             | `agh-captain`                             |
| `captain.secret.db.password`                      | Database password                                         | `""`                                      |
| `captain.secret.minio.enabled`                    | Enable secret generate for Minio                          | `true`                                    |
| `captain.secret.minio.secretName`                 | Secret name for Minio                                     | `capt-minio-secret`                       |
| `captain.secret.minio.user`                       | Minio user                                                | `capt-minio-user`                         |
| `captain.secret.minio.password`                   | Minio password                                            | `""`                                      |
| `captain.secret.jwt.enabled`                      | Enable secret generate for JWT                            | `true`                                    |
| `captain.secret.jwt.secretName`                   | Secret name for JWT                                       | `capt-jwt-secret`                         |
| `captain.secret.jwt.secret`                       | JWT secret                                                | `""`                                      |
| `captain.secret.superadmin.enabled`               | Enable secret generate for Super Admin                    | `true`                                    |
| `captain.secret.superadmin.secretName`            | Secret name for Super Admin                               | `capt-superadmin-secret`                  |
| `captain.secret.superadmin.password`              | Super Admin password                                      | `""`                                      |
| `captain.service`                                 | Captain service parameters                                |                                           |
| `captain.service.redis.enabled`                   | Enable redis                                              | `true`                                    |
| `captain.service.checkinDaemon.enabled`           | Enable checkin-daemon                                     | `true`                                    |
| `captain.service.checkinDaemon.image.repository`  | Checkin-Daemon image repository                           | `leukocyte-lab/argushack2/checkin-daemon` |
| `captain.service.checkinDaemon.image.tag`         | Checkin-Daemon image tag (immutable tags are recommended) | `v0.1.0`                                  |
| `captain.service.checkinDaemon.image.pullPolicy`  | Checkin-Daemon image pull policy                          | `IfNotPresent`                            |
| `captain.service.checkinDaemon.image.pullSecrets` | Specify docker-registry secret names as an array          | `[]`                                      |
| `captain.service.checkinDaemon.schedule`          | Checkin-Daemon cronjob schedule                           | `0 0 * * *`                               |
| `captain.extraEnv`                                | Captain additional environment variables                  | `{}`                                      |


### AGH2-Core parameters

Core module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Core

| Name                           | Description                                      | Value                           |
| ------------------------------ | ------------------------------------------------ | ------------------------------- |
| `core.enabled`                 | Enable Core module                               | `true`                          |
| `core.image.repository`        | Core image repository                            | `leukocyte-lab/argushack2/core` |
| `core.image.tag`               | Core image tag (immutable tags are recommended)  | `v1.20.2`                       |
| `core.image.pullPolicy`        | Core image pull policy                           | `IfNotPresent`                  |
| `core.image.pullSecrets`       | Specify docker-registry secret names as an array | `[]`                            |
| `core.secret.enabled`          | Enable secret generate for Core                  | `true`                          |
| `core.secret.db.enabled`       | Enable secret generate for Core database         | `true`                          |
| `core.secret.db.name`          | Database name                                    | `core-db`                       |
| `core.secret.db.user`          | Database user                                    | `agh-core`                      |
| `core.secret.db.password`      | Database password                                | `""`                            |
| `core.secret.minio.enabled`    | Enable secret generate for Minio                 | `true`                          |
| `core.secret.minio.secretName` | Secret name for Minio                            | `core-minio-secret`             |
| `core.secret.minio.user`       | Minio user                                       | `core-minio-user`               |
| `core.secret.minio.password`   | Minio password                                   | `""`                            |
| `core.service`                 | Core service parameters                          |                                 |
| `core.service.redis.enabled`   | Enable redis                                     | `true`                          |
| `core.env`                     | Core environment variables                       |                                 |
| `core.env.REGISTRY_URL`        | Core registry URL                                | `registry.lkc-lab.com`          |
| `core.extraEnv`                | Core additional environment variables            | `{}`                            |


### AGH2-Exploit-Manager parameters

Exploit-Manager module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Exploit-Manager

| Name                               | Description                                                | Value                                 |
| ---------------------------------- | ---------------------------------------------------------- | ------------------------------------- |
| `exploitmgr.enabled`               | Enable Exploit-Manager module                              | `true`                                |
| `exploitmgr.image.repository`      | Exploit-Manager image repository                           | `leukocyte-lab/argushack2/exploitmgr` |
| `exploitmgr.image.tag`             | Exploit-Manager image tag (immutable tags are recommended) | `v0.17.0`                             |
| `exploitmgr.image.pullPolicy`      | Exploit-Manager image pull policy                          | `IfNotPresent`                        |
| `exploitmgr.image.pullSecrets`     | Specify docker-registry secret names as an array           | `[]`                                  |
| `exploitmgr.secret.enabled`        | Enable secret generate for Exploit-Manager                 | `true`                                |
| `exploitmgr.secret.db.enabled`     | Enable secret generate for Exploit-Manager database        | `true`                                |
| `exploitmgr.secret.db.name`        | Database name                                              | `exploitmgr-db`                       |
| `exploitmgr.secret.db.user`        | Database user                                              | `agh-exploit`                         |
| `exploitmgr.secret.db.password`    | Database password                                          | `""`                                  |
| `exploitmgr.service`               | Exploit-Manager service parameters                         |                                       |
| `exploitmgr.service.redis.enabled` | Enable redis                                               | `true`                                |
| `exploitmgr.extraEnv`              | Exploit-Manager additional environment variables           | `{}`                                  |


### AGH2-Matcher parameters

Matcher module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Matcher

| Name                        | Description                                        | Value                              |
| --------------------------- | -------------------------------------------------- | ---------------------------------- |
| `matcher.enabled`           | Enable Matcher module                              | `false`                            |
| `matcher.image.repository`  | Matcher image repository                           | `leukocyte-lab/argushack2/matcher` |
| `matcher.image.tag`         | Matcher image tag (immutable tags are recommended) | `v1.2.2`                           |
| `matcher.image.pullPolicy`  | Matcher image pull policy                          | `IfNotPresent`                     |
| `matcher.image.pullSecrets` | Specify docker-registry secret names as an array   | `[]`                               |
| `matcher.extraEnv`          | Captain additional environment variables           | `{}`                               |


### AGH2-Template parameters

Template module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Template

| Name                               | Description                                         | Value                               |
| ---------------------------------- | --------------------------------------------------- | ----------------------------------- |
| `template.enabled`                 | Enable Template module                              | `false`                             |
| `template.image.repository`        | Template image repository                           | `leukocyte-lab/argushack2/template` |
| `template.image.tag`               | Template image tag (immutable tags are recommended) | `v0.2.5`                            |
| `template.image.pullPolicy`        | Template image pull policy                          | `IfNotPresent`                      |
| `template.image.pullSecrets`       | Specify docker-registry secret names as an array    | `[]`                                |
| `template.secret.enabled`          | Enable secret generate for Template                 | `true`                              |
| `template.secret.db.enabled`       | Enable secret generate for Template database        | `true`                              |
| `template.secret.db.name`          | Database name                                       | `template-db`                       |
| `template.secret.db.user`          | Database user                                       | `agh-template`                      |
| `template.secret.db.password`      | Database password                                   | `""`                                |
| `template.secret.minio.enabled`    | Enable secret generate for Minio                    | `true`                              |
| `template.secret.minio.secretName` | Secret name for Minio                               | `template-minio-secret`             |
| `template.secret.minio.user`       | Minio user                                          | `""`                                |
| `template.secret.minio.password`   | Minio password                                      | `""`                                |
| `template.extraEnv`                | Template additional environment variables           | `{}`                                |


### AGH2-Transformer parameters

Transformer module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-Transformer

| Name                                | Description                                            | Value                                  |
| ----------------------------------- | ------------------------------------------------------ | -------------------------------------- |
| `transformer.enabled`               | Enable Transformer module                              | `false`                                |
| `transformer.image.repository`      | Transformer image repository                           | `leukocyte-lab/argushack2/transformer` |
| `transformer.image.tag`             | Transformer image tag (immutable tags are recommended) | `v1.1.0`                               |
| `transformer.image.pullPolicy`      | Transformer image pull policy                          | `IfNotPresent`                         |
| `transformer.image.pullSecrets`     | Specify docker-registry secret names as an array       | `[]`                                   |
| `transformer.service`               | Exploit-Manager service parameters                     |                                        |
| `transformer.service.redis.enabled` | Enable redis                                           | `true`                                 |
| `transformer.extraEnv`              | Captain additional environment variables               | `{}`                                   |


### AGH2-UI parameters

UI module for AGH2.
ref: https://github.com/Leukocyte-Lab/AGH2-UI

| Name                   | Description                                      | Value                               |
| ---------------------- | ------------------------------------------------ | ----------------------------------- |
| `ui.enabled`           | Enable UI module                                 | `true`                              |
| `ui.image.repository`  | UI image repository                              | `leukocyte-lab/argushack2/frontend` |
| `ui.image.tag`         | UI image tag (immutable tags are recommended)    | `v2.22.0`                           |
| `ui.image.pullPolicy`  | UI image pull policy                             | `IfNotPresent`                      |
| `ui.image.pullSecrets` | Specify docker-registry secret names as an array | `[]`                                |
| `ui.extraEnv`          | UI additional environment variables              | `{}`                                |


### System shared image parameters

| Name                            | Description                           | Value                                                     |
| ------------------------------- | ------------------------------------- | --------------------------------------------------------- |
| `shared.enabled`                | Enable shared image config generation | `true`                                                    |
| `shared.configMapName`          | Shared image configMap name           | `system-image`                                            |
| `shared.images.poster`          | Poster image                          | `leukocyte-lab/argushack2/worker/poster:v2.0.0`           |
| `shared.images.cronjob`         | Cronjob image                         | `leukocyte-lab/argushack2/worker/cronjob:v1.0.0`          |
| `shared.images.reportInit`      | Report init image                     | `leukocyte-lab/argushack2/worker/report-init:v0.0.8`      |
| `shared.images.reportGenerator` | Report generator image                | `leukocyte-lab/argushack2/worker/report-generator:v0.0.7` |
| `shared.images.reportTemplate`  | Report template image                 | `leukocyte-lab/argushack2/attack-report-template:v0.0.8`  |

