{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "AGH2.name" }}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "AGH2.fullname" -}}
{{- if .Values.fullnameOverride }}
  {{ .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{ $name := default .Chart.Name .Values.nameOverride }}
  {{- if contains $name .Release.Name }}
    {{ .Release.Name | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{ printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "AGH2.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "AGH2.labels" -}}
project: {{ .Release.Name }}
helm.sh/chart: {{ include "AGH2.chart" . }}
{{ include "AGH2.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "AGH2.selectorLabels" -}}
app.kubernetes.io/name: {{ include "AGH2.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "AGH2.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
  {{ default (include "AGH2.fullname" .) .Values.serviceAccount.name }}
{{- else }}
  {{ default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return DB connection string
Usage:
{{ include "connection-string" (dict "db" (merge .Values.path.to.secret.db .Values.db.connection) "context" $) }}
*/}}
{{- define "connection-string" -}}

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
Return the proper redis image name
*/}}
{{- define "redis.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.redis.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "redis.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.redis.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper db image name
*/}}
{{- define "db.image" -}}
{{- include "common.images.image" (dict "imageRoot" (default .Values.db.image .Values.postgresql.image) "global" .Values.global) }}
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
Return the proper Core image name
*/}}
{{- define "core.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.core.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "core.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.core.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Exploit Manager image name
*/}}
{{- define "exploitmgr.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.exploitmgr.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "exploitmgr.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.exploitmgr.image) "global" .Values.global) }}
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
