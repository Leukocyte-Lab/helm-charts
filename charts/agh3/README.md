# AGH3

## Install

```bash
helm repo add lkclab https://charts.lkc-lab.com/
helm repo update

helm install agh2 lkclab/agh2
```

## Parameters

### Global parameters


### Image Registry parameters

| Name                      | Description                                     | Value                  |
| ------------------------- | ----------------------------------------------- | ---------------------- |
| `global.imageRegistry`    | Global Docker Image registry                    | `registry.lkc-lab.com` |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `["lkc-registry"]`     |

### Proxy parameters

| Name                      | Description                                                           | Value   |
| ------------------------- | --------------------------------------------------------------------- | ------- |
| `global.proxy.enabled`    | Enable the use of a proxy                                             | `false` |
| `global.proxy.httpProxy`  | HTTP Proxy server (ex: http://user:password@proxy.example.com:1080)   | `""`    |
| `global.proxy.httpsProxy` | HTTPS Proxy server (ex: https://user:password@proxy.example.com:4380) | `""`    |
| `global.proxy.noProxy`    | No Proxy targets (ex: 127.0.0.0/8,10.0.0.0/8)                         | `""`    |

### Common parameters

| Name                               | Description                                                                                                          | Value  |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------- | ------ |
| `global.storageClass`              | Global storage class for dynamic provisioning                                                                        | `""`   |
| `global.volumePermissions.enabled` | Enable init container that changes the owner and group of the persistent volume(s) mountpoint to `runAsUser:fsGroup` | `true` |

### Security parameters

| Name                                  | Description                                                                                                | Value  |
| ------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------ |
| `global.security.allowInsecureImages` | Allow unrecognized images, this is be use for `grafana-tempo/charts/memcached/templates/NOTES.txt` warning | `true` |

### crds parameters

| Name                           | Description                 | Value                          |
| ------------------------------ | --------------------------- | ------------------------------ |
| `crds.volume.name`             | Name of the volume          | `crd-volume`                   |
| `crds.job.name`                | Name of the job             | `actions-crd-job`              |
| `crds.job.image.repository`    | Image repository            | `docker/bitnamilegacy/kubectl` |
| `crds.job.image.tag`           | Image tag                   | `1.28.15-debian-12-r5`         |
| `crds.job.image.pullPolicy`    | Image pull policy           | `IfNotPresent`                 |
| `crds.job.image.pullSecrets`   | Image pull secrets          | `[]`                           |
| `crds.job.serviceAccount.name` | Name of the service account | `actions-crds-job-sa`          |
| `crds.cm.name`                 | Name of the config map      | `actions-crd`                  |

### Common parameters

| Name                                 | Description                                       | Value                  |
| ------------------------------------ | ------------------------------------------------- | ---------------------- |
| `customRegistrySecret.enabled`       | Enable custom registry secret generation          | `true`                 |
| `customRegistrySecret.auth.registry` | URL of the registry server                        | `registry.lkc-lab.com` |
| `customRegistrySecret.auth.username` | Username to authenticate with the registry server | `""`                   |
| `customRegistrySecret.auth.password` | Password to authenticate with the registry server | `""`                   |

### Keygen parameters

| Name                | Description                       | Value                   |
| ------------------- | --------------------------------- | ----------------------- |
| `keygen.enabled`    | Enable secret generate for keygen | `true`                  |
| `keygen.secretName` | Secret name for keygen            | `keygen-secret`         |
| `keygen.apiToken`   | Keygen API Token                  | `""`                    |
| `keygen.accountID`  | Keygen Account ID                 | `""`                    |
| `keygen.url`        | Keygen Endpoint URL               | `https://api.keygen.sh` |
| `ingress.enabled`   | Enable ingress controller         | `true`                  |
| `ingress.host`      | Ingress hostname                  | `app.argushack.com`     |

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

| Name                          | Description             | Value  |
| ----------------------------- | ----------------------- | ------ |
| `db.helpers.init.dbs.enabled` | Enable dbs init feature | `true` |

### Internal Postfix provisioning parameters

Leave as default if using external Postfix Server

| Name                        | Description                                                 | Value                              |
| --------------------------- | ----------------------------------------------------------- | ---------------------------------- |
| `postfix.enabled`           | Enable internal postfix                                     | `true`                             |
| `postfix.image.repository`  | Internal postfix image repository                           | `leukocyte-lab/argushack3/postfix` |
| `postfix.image.tag`         | Internal postfix image tag (immutable tags are recommended) | `production`                       |
| `postfix.image.pullPolicy`  | Internal postfix image pull policy                          | `IfNotPresent`                     |
| `postfix.image.pullSecrets` | Specify docker-registry secret names as an array            | `[]`                               |

### Postfix service provisioning parameters

Leave as default if using internal Postfix

| Name                            | Description                                              | Value                               |
| ------------------------------- | -------------------------------------------------------- | ----------------------------------- |
| `postfix.service.type`          | Postfix service type                                     | `ClusterIP`                         |
| `postfix.service.port`          | Postfix service port                                     | `25`                                |
| `postfix.dkim.image.repository` | Internal DKIM image repository                           | `leukocyte-lab/argushack3/opendkim` |
| `postfix.dkim.image.tag`        | Internal DKIM image tag (immutable tags are recommended) | `production`                        |
| `postfix.dkim.image.pullPolicy` | Internal DKIM image pull policy                          | `IfNotPresent`                      |
| `postfix.mydomain`              | Postfix mydomain                                         | `bas-mail-test.com`                 |
| `postfix.mail_myhostname`       | Postfix mail_myhostname                                  | `smtp.bas-mail-test.com`            |
| `postfix.domain`                | Postfix domain                                           | `bas-mail-test.com`                 |

### Internal PostgreSQL database provisioning parameters

Leave as default if using external DB

| Name                                         | Description                                                   | Value                                           |
| -------------------------------------------- | ------------------------------------------------------------- | ----------------------------------------------- |
| `postgresql.enabled`                         | Enable internal database                                      | `true`                                          |
| `postgresql.image.repository`                | Internal database image repository                            | `docker/bitnamilegacy/postgresql`               |
| `postgresql.image.tag`                       | Internal database image tag (immutable tags are recommended)  | `15.7.0`                                        |
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

| Name                                     | Description                                                      | Value                               |
| ---------------------------------------- | ---------------------------------------------------------------- | ----------------------------------- |
| `minio.internal.enabled`                 | Enable internal minio                                            | `true`                              |
| `minio.image.repository`                 | Internal MinIO image repository                                  | `docker/bitnamilegacy/minio`        |
| `minio.image.tag`                        | Internal MinIO image tag (immutable tags are recommended)        | `2024.11.7-debian-12-r2`            |
| `minio.image.pullPolicy`                 | Internal MinIO image pull policy                                 | `IfNotPresent`                      |
| `minio.image.pullSecrets`                | Specify docker-registry secret names as an array                 | `[]`                                |
| `minio.clientImage.repository`           | Internal MinIO image repository                                  | `docker/bitnamilegacy/minio-client` |
| `minio.clientImage.tag`                  | Internal MinIO image tag (immutable tags are recommended)        | `2024.11.17-debian-12-r1`           |
| `minio.clientImage.pullPolicy`           | Internal MinIO image pull policy                                 | `IfNotPresent`                      |
| `minio.clientImage.pullSecrets`          | Specify docker-registry secret names as an array                 | `[]`                                |
| `minio.helpers.test.image.repository`    | Minio Connection Test image repository                           | `docker/curlimages/curl`            |
| `minio.helpers.test.image.tag`           | Minio Connection Test image tag (immutable tags are recommended) | `8.15.0`                            |
| `minio.helpers.test.image.pullPolicy`    | Minio Connection Test image pull policy                          | `IfNotPresent`                      |
| `minio.helpers.test.image.pullSecrets`   | Specify docker-registry secret names as an array                 | `[]`                                |
| `minio.helpers.bucket.image.repository`  | Minio Bucket Test image repository                               | `docker/minio/mc`                   |
| `minio.helpers.bucket.image.tag`         | Minio Bucket Test image tag(immutable tags are recommended)      | `RELEASE.2025-07-16T15-35-03Z`      |
| `minio.helpers.bucket.image.pullPolicy`  | Minio Bucket Test image pull policy                              | `IfNotPresent`                      |
| `minio.helpers.bucket.image.pullSecrets` | Specify docker-registry secret names as an array                 | `[]`                                |
| `minio.auth.rootUser`                    | Internal database root user                                      | `argushack`                         |
| `minio.auth.rootPassword`                | Internal database root password                                  | `""`                                |
| `minio.provisioning.enabled`             | Enable minio provisioning                                        | `true`                              |
| `minio.provisioning.generateUser`        | Enable minio user generation                                     | `true`                              |
| `minio.extraEnvVarsCM`                   |                                                                  | `agh-minio-cm`                      |
| `minio.persistence.mountPath`            | Data volume mount path                                           | `/data`                             |

### Kueue parameters

| Name                      | Description               | Value               |
| ------------------------- | ------------------------- | ------------------- |
| `kueue.enabled`           | Enable internal kueue     | `false`             |
| `kueue.queueName.cluster` | Cluster queue name        | `agh3-cluster-pool` |
| `kueue.queueName.local`   | Local queue name          | `agh3-local-pool`   |
| `kueue.concurrentJobs`    | Number of concurrent jobs | `100`               |

### Redis parameters

| Name                                   | Description                                                      | Value                        |
| -------------------------------------- | ---------------------------------------------------------------- | ---------------------------- |
| `redis.enabled`                        | Enable internal redis                                            | `true`                       |
| `redis.image.repository`               | Internal Redis image repository                                  | `docker/bitnamilegacy/redis` |
| `redis.image.tag`                      | Internal Redis image tag (immutable tags are recommended)        | `7.4.0`                      |
| `redis.image.pullPolicy`               | Internal Redis image pull policy                                 | `IfNotPresent`               |
| `redis.image.pullSecrets`              | Specify docker-registry secret names as an array                 | `[]`                         |
| `redis.secret.secretName`              | Name of the generated secret                                     | `agh-redis-secret`           |
| `redis.secret.password`                | Redis password                                                   | `""`                         |
| `redis.helpers.test.image.repository`  | Redis Connection Test image repository                           | `docker/library/redis`       |
| `redis.helpers.test.image.tag`         | Redis Connection Test image tag (immutable tags are recommended) | `7-alpine`                   |
| `redis.helpers.test.image.pullPolicy`  | Redis Connection Test image pull policy                          | `IfNotPresent`               |
| `redis.helpers.test.image.pullSecrets` | Specify docker-registry secret names as an array                 | `[]`                         |

### RabbitMQ parameters

| Name                           | Description                                          | Value                 |
| ------------------------------ | ---------------------------------------------------- | --------------------- |
| `rabbitmq.queueName`           | Name of the RabbitMQ queue                           | `action_crd_result`   |
| `rabbitmq.connection.type`     | Choose to use external RabbitMQ or internal RabbitMQ | `internal`            |
| `rabbitmq.connection.protocol` | RabbitMQ protocol                                    | `amqp`                |
| `rabbitmq.connection.host`     | RabbitMQ host address                                | `mq.example.com`      |
| `rabbitmq.connection.port`     | RabbitMQ host port                                   | `5672`                |
| `rabbitmq.connection.user`     | RabbitMQ user                                        | `argushack`           |
| `rabbitmq.connection.password` | RabbitMQ password                                    | `""`                  |
| `rabbitmq.secret.enabled`      | Enable rabbitmq secret generation                    | `true`                |
| `rabbitmq.secret.secretName`   | Name of the generated secret                         | `agh-rabbitmq-secret` |

### Internal RabbitMQ provisioning parameters

Leave as default if using external RabbitMQ

| Name                         | Description                                                  | Value                           |
| ---------------------------- | ------------------------------------------------------------ | ------------------------------- |
| `rabbitmq.internal.enabled`  | Enable internal rabbitmq                                     | `true`                          |
| `rabbitmq.image.repository`  | Internal RabbitMQ image repository                           | `docker/bitnamilegacy/rabbitmq` |
| `rabbitmq.image.tag`         | Internal RabbitMQ image tag (immutable tags are recommended) | `3.12.13-debian-12-r2`          |
| `rabbitmq.image.pullPolicy`  | Internal RabbitMQ image pull policy                          | `IfNotPresent`                  |
| `rabbitmq.image.pullSecrets` | Specify docker-registry secret names as an array             | `[]`                            |

### RabbitMQ service provisioning parameters

Leave as default if using external RabbitMQ

| Name                             | Description                               | Value   |
| -------------------------------- | ----------------------------------------- | ------- |
| `rabbitmq.service.ports.amqp`    | Amqp service port                         | `5672`  |
| `rabbitmq.service.ports.amqpTls` | Amqp TLS service port                     | `5671`  |
| `rabbitmq.service.ports.dist`    | Erlang distribution service port          | `25672` |
| `rabbitmq.service.ports.manager` | RabbitMQ Manager service port             | `15672` |
| `rabbitmq.service.ports.metrics` | RabbitMQ Prometheues metrics service port | `9419`  |
| `rabbitmq.service.ports.epmd`    | EPMD Discovery service port               | `4369`  |

### Helper parameters

Control the DB Helper behaviors.

| Name                                      | Description                                                         | Value                    |
| ----------------------------------------- | ------------------------------------------------------------------- | ------------------------ |
| `rabbitmq.helpers.test.image.repository`  | RabbitMQ Connection Test image repository                           | `docker/curlimages/curl` |
| `rabbitmq.helpers.test.image.tag`         | RabbitMQ Connection Test image tag (immutable tags are recommended) | `7.78.0`                 |
| `rabbitmq.helpers.test.image.pullPolicy`  | RabbitMQ Connection Test image pull policy                          | `IfNotPresent`           |
| `rabbitmq.helpers.test.image.pullSecrets` | Specify docker-registry secret names as an array                    | `[]`                     |

### AGH3-Action-Loop parameters

Action Loop module for AGH3.
ref: https://github.com/Leukocyte-Lab/AGH3-Captain

| Name                               | Description                                            | Value                                     |
| ---------------------------------- | ------------------------------------------------------ | ----------------------------------------- |
| `actionLoop.enabled`               | Enable Action Loop module                              | `true`                                    |
| `actionLoop.replicaCount`          | Number of Action Loop replicas                         | `3`                                       |
| `actionLoop.image.repository`      | Action Loop image repository                           | `leukocyte-lab/argushack3/ctr-actionloop` |
| `actionLoop.image.tag`             | Action Loop image tag (immutable tags are recommended) | `v1.15.7`                                 |
| `actionLoop.image.pullPolicy`      | Action Loop image pull policy                          | `IfNotPresent`                            |
| `actionLoop.image.pullSecrets`     | Specify docker-registry secret names as an array       | `[]`                                      |
| `actionLoop.serviceAccount.create` | Create serviceAccount for Action Loop                  | `true`                                    |
| `actionLoop.serviceAccount.name`   | Name of the serviceAccount for Action Loop             | `action-loop-sa`                          |
| `actionLoop.rbac.create`           | Create RBAC for Action Loop                            | `true`                                    |

### AGH3-Captain parameters

Captain module for AGH3.
ref: https://github.com/Leukocyte-Lab/AGH3-Captain

| Name                                   | Description                                                                                       | Value                                  |
| -------------------------------------- | ------------------------------------------------------------------------------------------------- | -------------------------------------- |
| `captain.enabled`                      | Enable Captain module                                                                             | `true`                                 |
| `captain.image.repository`             | Captain image repository                                                                          | `leukocyte-lab/argushack3/ctr-captain` |
| `captain.image.tag`                    | Captain image tag (immutable tags are recommended)                                                | `v1.15.7`                              |
| `captain.image.pullPolicy`             | Captain image pull policy                                                                         | `IfNotPresent`                         |
| `captain.image.pullSecrets`            | Specify docker-registry secret names as an array                                                  | `[]`                                   |
| `captain.secret.enabled`               | Enable secret generate for Captain                                                                | `true`                                 |
| `captain.secret.db.enabled`            | Enable secret generate for Captain database                                                       | `true`                                 |
| `captain.secret.db.name`               | Database name                                                                                     | `captain-db`                           |
| `captain.secret.db.user`               | Database user                                                                                     | `agh-captain`                          |
| `captain.secret.db.password`           | Database password                                                                                 | `""`                                   |
| `captain.secret.minio.enabled`         | Enable secret generate for Minio                                                                  | `true`                                 |
| `captain.secret.minio.secretName`      | Secret name for Minio                                                                             | `capt-minio-secret`                    |
| `captain.secret.minio.user`            | Minio user                                                                                        | `capt-minio-user`                      |
| `captain.secret.minio.password`        | Minio password                                                                                    | `""`                                   |
| `captain.secret.minio.resourcesPreset` | Minio resources preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge) | `small`                                |
| `captain.secret.jwt.enabled`           | Enable secret generate for JWT                                                                    | `true`                                 |
| `captain.secret.jwt.secretName`        | Secret name for JWT                                                                               | `capt-jwt-secret`                      |
| `captain.secret.jwt.secret`            | JWT secret                                                                                        | `""`                                   |
| `captain.secret.superadmin.enabled`    | Enable secret generate for Super Admin                                                            | `true`                                 |
| `captain.secret.superadmin.secretName` | Secret name for Super Admin                                                                       | `capt-superadmin-password`             |
| `captain.secret.superadmin.password`   | Super Admin password                                                                              | `""`                                   |
| `captain.secret.oidc.enabled`          | Enable secret generate for OIDC                                                                   | `false`                                |
| `captain.secret.oidc.secretName`       | Secret name for OIDC                                                                              | `capt-oidc-secret`                     |
| `captain.secret.oidc.url`              | OIDC user                                                                                         | `""`                                   |
| `captain.secret.oidc.clientID`         | OIDC user                                                                                         | `""`                                   |
| `captain.secret.oidc.clientSecret`     | OIDC password                                                                                     | `""`                                   |
| `captain.secret.oidc.realm`            | OIDC realm                                                                                        | `""`                                   |
| `captain.serviceAccount.create`        | Create serviceAccount for Captain                                                                 | `true`                                 |
| `captain.serviceAccount.name`          | Name of the serviceAccount for Captain                                                            | `captain-sa`                           |
| `captain.rbac.create`                  | Create RBAC for Captain                                                                           | `true`                                 |
| `captain.extraEnv`                     | Captain additional environment variables                                                          | `{}`                                   |

### packet parameters

Packet module for AGH3.
descriptionEnd
@param packet.secret.enabled Enable secret generate for packet

@param packet.secret.minio.enabled Enable secret generate for Minio
@param packet.secret.minio.secretName Secret name for Minio
@param packet.secret.minio.user Minio user
@param packet.secret.minio.password Minio password


| Name                             | Description                       | Value                 |
| -------------------------------- | --------------------------------- | --------------------- |
| `packet.secret.enabled`          | Enable secret generate for packet | `true`                |
| `packet.secret.minio.enabled`    | Enable secret generate for Minio  | `true`                |
| `packet.secret.minio.secretName` | Secret name for Minio             | `packet-minio-secret` |
| `packet.secret.minio.user`       | Minio user                        | `packet-minio-user`   |
| `packet.secret.minio.password`   | Minio password                    | `""`                  |

### ai-parser parameters

@section ai-parser parameters
@descriptionStart
AI Parser module for AGH3.

| Name                             | Description                                       | Value                              |
| -------------------------------- | ------------------------------------------------- | ---------------------------------- |
| `parser.secret.enabled`          | Enable secret generate for Parser                 | `true`                             |
| `parser.secret.minio.enabled`    | Enable secret generate for Minio                  | `true`                             |
| `parser.secret.minio.secretName` | Secret name for Minio                             | `parser-minio-secret`              |
| `parser.secret.minio.user`       | Minio user                                        | `parser-minio-user`                |
| `parser.secret.minio.password`   | Minio password                                    | `""`                               |
| `parser.secret.sa.enabled`       | Enable secret generate for Parser service account | `false`                            |
| `parser.secret.sa.secretName`    | Secret name for Parser service account            | `parser-sa-secret`                 |
| `parser.secret.sa.json`          | Parser service account JSON                       | `{
  "type": "service_account",
}` |

### AGH3-Controller parameters

Controller module for AGH3.
ref: https://github.com/Leukocyte-Lab/AGH3-Controller

| Name                                 | Description                                           | Value                                     |
| ------------------------------------ | ----------------------------------------------------- | ----------------------------------------- |
| `controller.enabled`                 | Enable Controller module                              | `true`                                    |
| `controller.image.repository`        | Controller image repository                           | `leukocyte-lab/argushack3/ctr-controller` |
| `controller.image.tag`               | Controller image tag (immutable tags are recommended) | `v1.2.0`                                  |
| `controller.image.pullPolicy`        | Controller image pull policy                          | `IfNotPresent`                            |
| `controller.image.pullSecrets`       | Specify docker-registry secret names as an array      | `[]`                                      |
| `controller.secret.enabled`          | Enable secret generate for Controller                 | `true`                                    |
| `controller.secret.minio.enabled`    | Enable secret generate for Minio                      | `true`                                    |
| `controller.secret.minio.secretName` | Secret name for Minio                                 | `executor-minio-secret`                   |
| `controller.secret.minio.user`       | Minio user                                            | `executor-minio-user`                     |
| `controller.secret.minio.password`   | Minio password                                        | `""`                                      |
| `controller.serviceAccount.create`   | Create serviceAccount for Controller                  | `true`                                    |
| `controller.serviceAccount.name`     | Name of the serviceAccount for Controller             | `controller-sa`                           |
| `controller.rbac.create`             | Create RBAC for Controller                            | `true`                                    |
| `controller.env`                     | Controller environment variables                      |                                           |
| `controller.env.REGISTRY_URL`        | Controller registry URL                               | `registry.lkc-lab.com`                    |
| `controller.extraEnv`                | Controller additional environment variables           | `{}`                                      |

### AGH3-UI parameters

UI module for AGH3.
ref: https://github.com/Leukocyte-Lab/AGH3-UI

| Name                   | Description                                      | Value                             |
| ---------------------- | ------------------------------------------------ | --------------------------------- |
| `ui.enabled`           | Enable UI module                                 | `true`                            |
| `ui.image.repository`  | UI image repository                              | `leukocyte-lab/argushack3/ctr-ui` |
| `ui.image.tag`         | UI image tag (immutable tags are recommended)    | `v1.13.8`                         |
| `ui.image.pullPolicy`  | UI image pull policy                             | `IfNotPresent`                    |
| `ui.image.pullSecrets` | Specify docker-registry secret names as an array | `[]`                              |
| `ui.extraEnv`          | UI additional environment variables              | `{}`                              |

### AGH3-Report parameters

Report module for AGH3.
ref: https://github.com/Leukocyte-Lab/AGH3-Report

| Name                       | Description                                       | Value                             |
| -------------------------- | ------------------------------------------------- | --------------------------------- |
| `report.enabled`           | Enable Report module                              | `true`                            |
| `report.image.repository`  | Report image repository                           | `leukocyte-lab/argushack3/report` |
| `report.image.tag`         | Report image tag (immutable tags are recommended) | `v1.2.6`                          |
| `report.image.pullPolicy`  | Report image pull policy                          | `IfNotPresent`                    |
| `report.image.pullSecrets` | Specify docker-registry secret names as an array  | `[]`                              |
| `report.extraEnv`          | UI additional environment variables               | `{}`                              |

### cluster-feature-enabler parameters

| Name                                                   | Description                                                        | Value                                |
| ------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------ |
| `clusterFeatureEnabler.enabled`                        | Enable Cluster Feature Enabler module                              | `true`                               |
| `clusterFeatureEnabler.image.repository`               | Cluster Feature Enabler image repository                           | `docker/bitnamilegacy/kubectl`       |
| `clusterFeatureEnabler.image.tag`                      | Cluster Feature Enabler image tag (immutable tags are recommended) | `1.28.15-debian-12-r5`               |
| `clusterFeatureEnabler.image.pullPolicy`               | Cluster Feature Enabler image pull policy                          | `IfNotPresent`                       |
| `clusterFeatureEnabler.image.pullSecrets`              | Specify docker-registry secret names as an array                   | `[]`                                 |
| `clusterFeatureEnabler.serviceAccount.create`          | Create serviceAccount for Cluster Feature Enabler                  | `true`                               |
| `clusterFeatureEnabler.serviceAccount.name`            | Name of the serviceAccount for Cluster Feature Enabler             | `cluster-feature-enabler-sa`         |
| `clusterFeatureEnabler.jobs.sidecarContainers.enabled` | Enable Sidecar Containers feature enabler job                      | `true`                               |
| `clusterFeatureEnabler.jobs.sidecarContainers.name`    | Sidecar Containers feature enabler job name                        | `sidecar-containers-feature-enabler` |

### Vector parameters

Vector observability agent for AGH3 captain, action-loop, and controller modules.
ref: https://vector.dev

| Name                      | Description                                                               | Value             |
| ------------------------- | ------------------------------------------------------------------------- | ----------------- |
| `vector.enabled`          | Enable Vector observability agent for captain, action-loop and controller | `false`           |
| `vector.image.repository` | Vector image repository                                                   | `timberio/vector` |
| `vector.image.tag`        | Vector image tag (immutable tags are recommended)                         | `latest-debian`   |

### Grafana parameters

Grafana dashboard service for visualizing metrics, logs, and traces.
ref: https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/

| Name                                         | Description                                                          | Value                    |
| -------------------------------------------- | -------------------------------------------------------------------- | ------------------------ |
| `grafana.enabled`                            | Enable Grafana                                                       | `false`                  |
| `grafana.image.repository`                   | Grafana image repository                                             | `docker/grafana/grafana` |
| `grafana.initChownData.enabled`              | Enable init container for setting data directory ownership           | `false`                  |
| `grafana.initChownData.image.repository`     | Init container image repository for setting data directory ownership | `docker/busybox`         |
| `grafana.downloadDashboardsImage.repository` | Image repository used to download dashboards                         | `docker/curlimages/curl` |
| `grafana.persistence.enabled`                | Enable Grafana persistence                                           | `true`                   |
| `grafana.persistence.type`                   | Persistence type for Grafana (pvc or other supported types)          | `pvc`                    |
| `grafana.fullnameOverride`                   | Fullname override for Grafana                                        | `grafana`                |

### Grafana Tempo parameters

Grafana Tempo distributed tracing backend.
ref: https://artifacthub.io/packages/helm/bitnami/grafana-tempo

| Name                                               | Description                                     | Value                                        |
| -------------------------------------------------- | ----------------------------------------------- | -------------------------------------------- |
| `grafana-tempo.enabled`                            | Enable Grafana Tempo                            | `false`                                      |
| `grafana-tempo.image.repository`                   | Tempo image repository                          | `docker/bitnamilegacy/grafana-tempo`         |
| `grafana-tempo.tempo.image.repository`             | Tempo image repository                          | `docker/bitnamilegacy/grafana-tempo`         |
| `grafana-tempo.tempo.traces.otlp.grpc`             | Enable gRPC for OTLP receiver                   | `true`                                       |
| `grafana-tempo.queryFrontend.image.repository`     | Tempo query frontend image repository           | `docker/bitnamilegacy/grafana-tempo-query`   |
| `grafana-tempo.vulture.image.repository`           | Tempo vulture image repository                  | `docker/bitnamilegacy/grafana-tempo-vulture` |
| `grafana-tempo.volumePermissions.image.repository` | Image repository for setting volume permissions | `docker/bitnamilegacy/os-shell`              |
| `grafana-tempo.volumePermissions.image.tag`        | Image tag for setting volume permissions        | `12-debian-12-r49`                           |
| `grafana-tempo.ingester.resources.requests.memory` | Ingester memory requests                        | `512Mi`                                      |
| `grafana-tempo.ingester.resources.requests.cpu`    | Ingester CPU requests                           | `250m`                                       |
| `grafana-tempo.ingester.resources.limits.memory`   | Ingester memory limits                          | `2Gi`                                        |
| `grafana-tempo.ingester.resources.limits.cpu`      | Ingester CPU limits                             | `1000m`                                      |
| `grafana-tempo.memcached.enabled`                  | Enable memcached for Tempo                      | `false`                                      |
| `grafana-tempo.externalMemcached.host`             | External memcached host address                 | `memcached.agh.svc.cluster.local`            |
| `grafana-tempo.externalMemcached.port`             | External memcached port                         | `11211`                                      |
| `grafana-tempo.fullnameOverride`                   | Fullname override for Grafana Tempo             | `grafana-tempo`                              |

### Grafana Loki parameters

Grafana Loki log aggregation system.
ref: https://artifacthub.io/packages/helm/bitnami/grafana-loki

| Name                                              | Description                                            | Value                               |
| ------------------------------------------------- | ------------------------------------------------------ | ----------------------------------- |
| `grafana-loki.enabled`                            | Enable Grafana Loki                                    | `false`                             |
| `grafana-loki.loki.image.repository`              | Loki image repository                                  | `docker/bitnamilegacy/grafana-loki` |
| `grafana-loki.loki.image.tag`                     | Loki image tag (immutable tags are recommended)        | `3.5.3-debian-12-r0`                |
| `grafana-loki.compactor.extraArgs`                | Additional arguments for compactor                     | `["-config.expand-env=true"]`       |
| `grafana-loki.distributor.extraArgs`              | Additional arguments for distributor                   | `["-config.expand-env=true"]`       |
| `grafana-loki.ingester.extraArgs`                 | Additional arguments for ingester                      | `["-config.expand-env=true"]`       |
| `grafana-loki.querier.extraArgs`                  | Additional arguments for querier                       | `["-config.expand-env=true"]`       |
| `grafana-loki.queryFrontend.extraArgs`            | Additional arguments for query frontend                | `["-config.expand-env=true"]`       |
| `grafana-loki.gateway.image.repository`           | Loki gateway image repository                          | `docker/bitnamilegacy/nginx`        |
| `grafana-loki.gateway.image.tag`                  | Loki gateway image tag                                 | `1.29.0-debian-12-r5`               |
| `grafana-loki.volumePermissions.image.repository` | Image repository for setting volume permissions        | `docker/bitnamilegacy/os-shell`     |
| `grafana-loki.volumePermissions.image.tag`        | Image tag for setting volume permissions               | `12-debian-12-r49`                  |
| `grafana-loki.grafanaalloy.enabled`               | Enable integration with Grafana Alloy                  | `false`                             |
| `grafana-loki.memcachedchunks.enabled`            | Enable memcached for chunks caching                    | `false`                             |
| `grafana-loki.externalMemcachedChunks.host`       | External memcached host address (IP or FQDN in string) | `memcached.agh.svc.cluster.local`   |
| `grafana-loki.externalMemcachedChunks.port`       | External memcached port                                | `11211`                             |
| `grafana-loki.memcachedfrontend.enabled`          | Enable memcached for frontend caching                  | `false`                             |
| `grafana-loki.externalMemcachedFrontend.host`     | External memcached host address (IP or FQDN in string) | `memcached.agh.svc.cluster.local`   |
| `grafana-loki.externalMemcachedFrontend.port`     | External memcached port                                | `11211`                             |
| `grafana-loki.fullnameOverride`                   | Fullname override for Grafana Loki                     | `grafana-loki`                      |

### Memcached parameters

Memcached distributed caching system.
ref: https://artifacthub.io/packages/helm/bitnami/memcached

| Name                         | Description                                          | Value                            |
| ---------------------------- | ---------------------------------------------------- | -------------------------------- |
| `memcached.enabled`          | Enable Memcached                                     | `false`                          |
| `memcached.image.repository` | Memcached image repository                           | `docker/bitnamilegacy/memcached` |
| `memcached.image.tag`        | Memcached image tag (immutable tags are recommended) | `1.6.39-debian-12-r0`            |
| `memcached.fullnameOverride` | Fullname override for Memcached                      | `memcached`                      |
