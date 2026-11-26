# Bundled chart dependencies

The fixed versions in `Chart.lock` are bundled without changing their source
templates or notices. This permission review covers Helm chart source, and does
not authorize copying any container image or third-party registry cache.

| Chart | Version | Source and license evidence |
| --- | --- | --- |
| common | 2.19.1 | Bitnami; package headers and README declare Apache-2.0 |
| postgresql | 12.1.2 | Bitnami; package README declares Apache-2.0, copyright 2022 Bitnami |
| minio | 14.8.6 | Bitnami; package headers and README declare Apache-2.0 |
| rabbitmq | 13.0.0 | Bitnami; package headers and README declare Apache-2.0 |
| redis | 20.1.0 | Bitnami; package headers and README declare Apache-2.0 |
| grafana-loki | 6.0.2 | Bitnami; package headers and README declare Apache-2.0 |
| grafana-tempo | 4.0.14 | Bitnami; package headers and README declare Apache-2.0 |
| memcached | 7.9.4 | Bitnami; package headers and README declare Apache-2.0 |
| grafana | 9.3.0 | Grafana Helm Charts; Apache-2.0 at the exact grafana-9.3.0 source tag |
| postfix | 0.1.5 | Organization-owned chart, bundled from this repository; includes the same common dependency |

Bitnami packages preserve their copyright notices for Bitnami, VMware and/or
Broadcom. The upstream chart source license is
<https://github.com/bitnami/charts/blob/main/LICENSE.md>.
The Grafana license was read at commit
`9a2a0d3f36b70dc23bb8e5bfd49f43f6c5447538`:
<https://github.com/grafana/helm-charts/blob/9a2a0d3f36b70dc23bb8e5bfd49f43f6c5447538/LICENSE>.
The complete Apache 2.0 text is included as `licenses/Apache-2.0.txt`.
