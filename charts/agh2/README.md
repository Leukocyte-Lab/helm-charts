# AGH2-helm

## Install

```bash
helm repo add agh2 https://agh2.github.io/helm-charts
helm repo update

helm install agh2 agh2/agh2
```

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker Image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global storage class for dynamic provisioning   | `""`  |


### Database parameters

Leave `db.internal.*` as default if use external DB

| Name                           | Description                                                  | Value                  |
| ------------------------------ | ------------------------------------------------------------ | ---------------------- |
| `db.connection`                | Connection information for the database                      |                        |
| `db.connection.type`           | Choose to use external DB or internal DB                     | `external`             |
| `db.connection.host`           | Database host address                                        | `database.example.com` |
| `db.connection.port`           | Database host port                                           | `5432`                 |
| `db.connection.user`           | Database user                                                | `argushack`            |
| `db.connection.password`       | Database password                                            | `""`                   |
| `db.internal.enabled`          | Internal database                                            | `false`                |
| `db.internal.image.repository` | Internal database image repository                           | `bitnami/postgresql`   |
| `db.internal.image.tag`        | Internal database image tag (immutable tags are recommended) | `15.1.0-debian-11-r0`  |
| `db.internal.image.pullPolicy` | Internal database image pull policy                          | `IfNotPresent`         |

