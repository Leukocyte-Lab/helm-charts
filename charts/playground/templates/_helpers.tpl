{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "AGH3-Playground.name" }}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "AGH3-Playground.fullname" -}}
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
{{- define "AGH3-Playground.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "AGH3-Playground.labels" -}}
project: {{ .Release.Name }}
helm.sh/chart: {{ include "AGH3-Playground.chart" . }}
{{ include "AGH3-Playground.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "AGH3-Playground.selectorLabels" -}}
app.kubernetes.io/name: {{ include "AGH3-Playground.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "AGH3-Playground.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
  {{ default (include "AGH3-Playground.fullname" .) .Values.serviceAccount.name }}
{{- else }}
  {{ default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper UI image name
*/}}
{{- define "playground.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.playground.image "global" .Values.global) }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "playground.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.playground.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the API Endpoint
*/}}
{{- define "playground.apiEndpoint" -}}
{{- if eq .Values.playground.service.backendRef.kind "ExternalService" -}}
  {{ printf .Values.playground.service.backendRef.endpoint }}
{{- else -}}
  {{- $namespace := (coalesce .Values.playground.service.backendRef.namespace .Release.Namespace) }}
  {{- $name := .Values.playground.service.backendRef.name }}
  {{- $port := .Values.playground.service.backendRef.port }}
  {{- $protocol := (lower .Values.playground.service.backendRef.protocol) }}
  {{- $endpoint := .Values.playground.service.backendRef.endpoint }}
  {{- printf "%v://%v.%v.svc.cluster.local:%v%v" $protocol $name $namespace $port $endpoint }}
{{- end -}}
{{- end -}}
