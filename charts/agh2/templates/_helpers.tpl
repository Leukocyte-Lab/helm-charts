{{/*
Expand the name of the chart.
*/}}
{{- define "AGH2.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "AGH2.fullname" -}}
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
{{- define "AGH2.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "AGH2.labels" -}}
project: {{ .Release.Name -}}
helm.sh/chart: {{- include "AGH2.chart" . -}}
{{- include "AGH2.selectorLabels" . -}}
{{- if .Chart.AppVersion -}}
  app.kubernetes.io/version: {{ .Chart.AppVersion | quote -}}
{{- end -}}
  app.kubernetes.io/managed-by: {{ .Release.Service -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "AGH2.selectorLabels" -}}
app.kubernetes.io/name: {{- include "AGH2.name" . -}}
app.kubernetes.io/instance: {{ .Release.Name -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "AGH2.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
  {{- default (include "AGH2.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
  {{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}


{{/*
Create the image pull secret section
*/}}
{{- define "imagePullSecret" }}
{{- with .Values.imageCredential }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" (required "imageCredential.registry is required" .registry) (required "imageCredential.username is required" .username) (required "imageCredential.password is required" .password) (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}