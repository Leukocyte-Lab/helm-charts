{{/* vim: set filetype=mustache: */}}
{{/*
Validate required values are not empty.

Usage:
{{ include "validations.required" (dict "path" "some.values" "fields" (list "filed1" "field2") "msg" "customMessage" "context" .Values) }}
Params:
  - path: The path to the value to validate. (required)
  - fields: The fields to validate. (required)
  - msg: The message to display if validation fails. (optional)
  - context: The context values. (required)
*/}}
{{- define "validations.required" -}}
  {{- $value := include "utils.getValueFromKey" (
    dict
      "path" .path
      "context" .context
  ) | fromYaml -}}
  {{- $path := .path -}}
  {{- $msg := .msg -}}
  {{- $errorMsg := "" -}}
  {{- if empty $value -}}
    {{- $errorMsg = printf "[INVALID] %s is required%s"
      $path
      (empty $msg | ternary "" (printf ": %s" $msg))
    -}}
  {{- else -}}
    {{- range .fields -}}
      {{- $field := . -}}
      {{- if empty (get $value $field) -}}
        {{- $errorMsg = printf "%s\n%s"
              $errorMsg
              (
                printf
                  "[INVALID] %s.%s is required%s"
                  $path
                  $field
                  (empty $msg | ternary "" (printf ": %s" $msg))
              )
        -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- print (trimAll "\n" $errorMsg) -}}
{{- end -}}
