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
{{ include "connection-string" (dict "db" (merge .Values.db.connection .Values.path.to.secret.db .)) }}
*/}}
{{- define "connection-string" -}}
{{- $connStr := printf "%v://%v:%v@%v:%v/%v" .db.driver .db.user .db.password .db.host .db.port .db.name }}
{{- if and .db.options (default .disableSSL true) }}
  {{- printf "%v?sslmode=disable" $connStr | b64enc | quote }}
{{- else }}
  {{- printf $connStr | b64enc | quote }}
{{- end }}
{{- end }}

{{/*
Return the proper redis image name
*/}}
{{- define "redis.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.redis.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper db image name
*/}}
{{- define "db.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.db.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper ATTACK image name
*/}}
{{- define "attack.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.attack.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper group image name
*/}}
{{- define "attack.service.group.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.attack.service.group.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper UI image name
*/}}
{{- define "attack.service.ui.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.attack.service.ui.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "attack.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.attack.image .Values.attack.service.group.image .Values.attack.service.ui.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Blender image name
*/}}
{{- define "blender.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.blender.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "blender.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.blender.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Captain image name
*/}}
{{- define "captain.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.captain.image "global" .Values.global) }}
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
Return the proper Matcher image name
*/}}
{{- define "matcher.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.matcher.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "matcher.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.matcher.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Template image name
*/}}
{{- define "template.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.template.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "template.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.template.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Exploit Manager image name
*/}}
{{- define "transformer.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.transformer.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "transformer.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.transformer.image) "global" .Values.global) }}
{{- end -}}
