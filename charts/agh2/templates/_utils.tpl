{{/*
Gets a value from .Values given
Usage:
{{ include "utils.getValueFromKey" (dict "path" "path.to.key" "context" $) }}
Params:
  - path: The path to the value to validate. (required)
  - context: The context values. (required)
*/}}
{{- define "utils.getValueFromKey" -}}
{{- $splitKey := splitList "." .path -}}
{{- $value := dict -}}
{{- $latestObj := $.context.Values -}}
{{- range $splitKey -}}
  {{- $key := . -}}
  {{- $value = ( index $latestObj $key ) -}}
  {{- $latestObj = $value -}}
{{- end -}}
{{- $value | toYaml -}} 
{{- end -}}
