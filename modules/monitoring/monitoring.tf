resource "helm_release" "prometheus_monitoring" {
  name             = "prometheus"
  namespace        = var.namespace
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  version          = var.prometheus_chart_version
  create_namespace = true
}



resource "helm_release" "grafana_monitoring" {
  name             = "grafana"
  namespace        = var.namespace
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = var.grafana_chart_version
  create_namespace = true
}


