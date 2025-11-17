variable "namespace" {
  description = "K8s namespace for monitoring"
  type        = string
  default     = "monitoring"
}

variable "grafana_chart_version" {
  description = "Version of Grafana chart"
  type        = string
  default     = "10.1.4"
}

variable "prometheus_chart_version" {
  description = "Version of Prometheus chart"
  type        = string
  default     = "27.45.0"
}

