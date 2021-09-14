{{/*
Expand the name of the chart.
*/}}
{{- define "metal-csi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "metal-csi.drivername" -}}
{{- .Values.csidriver.name }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "metal-csi.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "metal-csi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "metal-csi.labels" -}}
helm.sh/chart: {{ include "metal-csi.chart" . }}
{{ include "metal-csi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "metal-csi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "metal-csi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "metal-csi.serviceAccountName" -}}
{{- if .Values.rbac.create }}
{{- default (include "metal-csi.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "metal-csi.clusterRoleName" -}}
{{- if .Values.rbac.create }}
{{- default (include "metal-csi.fullname" .) .Values.clusterRole.name }}
{{- else }}
{{- default "default" .Values.clusterRole.name }}
{{- end }}
{{- end }}

{{/*
Common arguments used for CSI helpers, such as node-driver-registrar
*/}}
{{- define "metal-csi.csiHelperArgs" -}}
- '--v=5'
- '--csi-address=$(ADDRESS)'
{{- end }}

{{/*
Common arguments used for CSI helpers, such as node-driver-registrar
*/}}
{{- define "metal-csi.csiHelperLeaderArgs" -}}
- --leader-election
- --leader-election-namespace={{ .Release.Namespace }}
- --timeout=90s
{{- end }}

{{/*
Common env vars used for CSI helpers, such as node-driver-registrar
*/}}
{{- define "metal-csi.csiHelperEnv" -}}
- name: ADDRESS
  value: /plugin/csi.sock
- name: KUBE_NODE_NAME
  valueFrom:
    fieldRef:
      fieldPath: spec.nodeName
{{- end }}

{{/*
Common env vars used for CSI helpers, such as node-driver-registrar
*/}}
{{- define "metal-csi.csiControllerHelperEnv" -}}
- name: ADDRESS
  value: /plugin/csi-controller.sock
- name: KUBE_NODE_NAME
  valueFrom:
    fieldRef:
      fieldPath: spec.nodeName
{{- end }}

{{/*
Common env vars used for CSI helpers, such as node-driver-registrar
*/}}
{{- define "metal-csi.csiHelperVolumeMounts" -}}
- name: plugin-dir
  mountPath: /plugin
- name: registration-dir
  mountPath: /registration
{{- end }}
