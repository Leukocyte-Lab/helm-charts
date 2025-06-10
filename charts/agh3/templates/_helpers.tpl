{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "AGH3.name" }}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "AGH3.fullname" -}}
{{- if .Values.fullnameOverride -}}
  {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
  {{- $name := default .Chart.Name .Values.nameOverride -}}
  {{- if contains $name .Release.Name -}}
    {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "AGH3.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "AGH3.labels" -}}
project: {{ .Release.Name }}
helm.sh/chart: {{ include "AGH3.chart" . }}
{{ include "AGH3.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "AGH3.selectorLabels" -}}
app.kubernetes.io/name: {{ include "AGH3.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "AGH3.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
  {{ default (include "AGH3.fullname" .) .Values.serviceAccount.name }}
{{- else }}
  {{ default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return DB connection string
Usage:
{{ include "db-connection-string" (dict "db" (merge .Values.path.to.secret.db .Values.db.connection) "context" $) }}
*/}}
{{- define "db-connection-string" -}}

{{- $iDBHost := printf "db.%v.svc.cluster.local" .context.Release.Namespace }}
{{- $connStr := printf "%v://%v:%v@%v:%v/%v"
  (required "db.connection.driver is required, set it or provide individually when use as macro function." .db.driver)
  (required "db.connection.user is required, set it or provide individually when use as macro function." .db.user)
  (required "db.connection.password is required, set it or provide individually when use as macro function." .db.password)
  (eq .db.type "internal" | ternary $iDBHost
    (required "db.connection.host is required, set it or provide individually when use as macro function." .db.host)
  )
  (required "db.connection.port is required, set it or provide individually when use as macro function." .db.port)
  (required "db.name is required, provide individually when use as macro function." .db.name)
}}

{{- if and .db.options (default .db.options.disableSSL true) }}
  {{- printf "%v?sslmode=disable" $connStr }}
{{- else }}
  {{- printf $connStr }}
{{- end }}
{{- end }}

{{/*
Return RabbitMQ connection string
Usage:
{{ include "rabbitmq-connection-string" (dict "rabbitmq" (merge .Values.path.to.secret.rabbitmq .Values.rabbitmq.connection) "context" $) }}
*/}}
{{- define "rabbitmq-connection-string" -}}

{{- $iMQHost := printf "rabbitmq.%v.svc.cluster.local" .context.Release.Namespace }}
{{- $connStr := printf "%v://%v:%v@%v:%v"
  (required "rabbitmq.connection.protocol is required, set it or provide individually when use as macro function." .rabbitmq.protocol)
  (required "rabbitmq.connection.user is required, set it or provide individually when use as macro function." .rabbitmq.user)
  (required "rabbitmq.connection.password is required, set it or provide individually when use as macro function." .rabbitmq.password)
  (eq .rabbitmq.type "internal" | ternary $iMQHost
    (required "rabbitmq.connection.host is required, set it or provide individually when use as macro function." .rabbitmq.host)
  )
  (required "rabbitmq.connection.port is required, set it or provide individually when use as macro function." .rabbitmq.port)
}}
{{- printf $connStr }}
{{- end }}

{{/*
Random password generator
Usage:
{{ include "random-password" (dict "prefix" "some-prefix" # optional "len" 24 # optional ) }}
*/}}
{{- define "random-password" -}}
{{- printf "%s%s" (default (printf "%s-" .prefix) "") (randAlphaNum (default .len 24) | nospace) }}
{{- end }}

{{/*
Specify password generator
Usage:
{{ include "specify-password" (dict "domain" "example.com" "token" "some-token" "prefix" "some-prefix" # required) }}
*/}}
{{- define "specify-password" -}}
{{- printf "%s-%s-%s-%s-%s"
  (required "specify-password required a prefix" .prefix | upper)
  (
    derivePassword
      1
      "pin"
      (required "specify-password required a token" .token)
      (required "specify-password required prefix" .prefix)
      (required "specify-password required domain" .domain)
  )
  (
    derivePassword
      1
      "short"
      (required "specify-password required a token" .token)
      (required "specify-password required prefix" .prefix | upper)
      (required "specify-password required domain" .domain)
  )
  (
    derivePassword
      1
      "pin"
      (required "specify-password required prefix" .prefix)
      (required "specify-password required a token" .token)
      (required "specify-password required domain" .domain)
  )
  (
    derivePassword
      1
      "basic"
      (required "specify-password required a token" .token | upper)
      (required "specify-password required prefix" .prefix)
      (required "specify-password required domain" .domain)
  )
}}
{{- end }}

{{/*
Return the proper db image name
*/}}
{{- define "db.image" -}}
{{- include "common.images.image" (dict "imageRoot" (default .Values.db.image .Values.postgresql.image) "global" .Values.global) }}
{{- end }}

{{/*
Return the proper actions-crds-job image name
*/}}
{{- define "actions-crds-job.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.crds.job.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper redis-test image name
*/}}
{{- define "redis-test.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.redis.helpers.test.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper rabbitmq-test-client image name
*/}}
{{- define "rabbitmq-test-client.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.rabbitmq.helpers.test.image "global" .Values.global) }}
{{- end }}

{{/*
  Return the proper minio-test-client image name
*/}}
{{- define "minio-test-client.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.minio.helpers.test.image "global" .Values.global) }}
{{- end }}

{{/*
  Return the proper minio-bucket-test-client image name
*/}}
{{- define "minio-bucket-test-client.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.minio.helpers.bucket.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper kueue-initialize image name
*/}}
{{- define "kueue-initialize.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.kueue.helpers.initialize.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Captain image name
*/}}
{{- define "captain.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.captain.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper checkin-daemon image name
*/}}
{{- define "captain.service.checkinDaemon.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.captain.service.checkinDaemon.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "captain.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.captain.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the name of the service account to use for the actions-crds-job
*/}}
{{- define "actions-crds-job.serviceAccountName" -}}
  {{- default (include "AGH3.fullname" .) .Values.crds.job.serviceAccount.name }}
{{- end -}}

{{/*
Return the name of the service account to use for the Captain
*/}}
{{- define "captain.serviceAccountName" -}}
  {{- if .Values.captain.serviceAccount.create }}
    {{- default (include "AGH3.fullname" .) .Values.captain.serviceAccount.name }}
  {{- else }}
    {{- default "default" .Values.captain.serviceAccount.name }}
{{- end }}
{{- end -}}

{{/*
Return the proper Action Loop image name
*/}}
{{- define "actionLoop.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.actionLoop.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "actionLoop.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.actionLoop.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the name of service account to use for Action Loop
*/}}
{{- define "actionLoop.serviceAccountName" -}}
  {{- if .Values.actionLoop.serviceAccount.create }}
    {{- default (include "AGH3.fullname" .) .Values.actionLoop.serviceAccount.name }}
  {{- else }}
    {{- default "default" .Values.actionLoop.serviceAccount.name }}
  {{- end }}
{{- end -}}

{{/*
Return the proper Core image name
*/}}
{{- define "controller.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.controller.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "controller.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.controller.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the name of the service account to use for the Controller
*/}}
{{- define "controller.serviceAccountName" -}}
  {{- if .Values.controller.serviceAccount.create }}
    {{- default (include "AGH3.fullname" .) .Values.controller.serviceAccount.name }}
  {{- else }}
    {{- default "default" .Values.controller.serviceAccount.name }}
  {{- end }}
{{- end -}}

{{/*
Return the proper UI image name
*/}}
{{- define "ui.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.ui.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "ui.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.ui.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper UI image name
*/}}
{{- define "report.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.report.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "report.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.report.image) "global" .Values.global) }}
{{- end -}}

{{/*
Global proxy settings as envs
*/}}
{{- define "global.proxy.envs" -}}
{{- if .Values.global.proxy.httpProxy -}}
- name: HTTP_PROXY
  value: {{ .Values.global.proxy.httpProxy -}}
{{- end }}
{{- if .Values.global.proxy.httpsProxy }}
- name: HTTPS_PROXY
  value: {{ .Values.global.proxy.httpsProxy -}}
{{- end }}
{{- if .Values.global.proxy.noProxy }}
- name: NO_PROXY
  value: {{ .Values.global.proxy.noProxy -}}
{{- end }}
{{- end -}}
