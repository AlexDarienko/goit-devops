resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "58.2.1"

  values = [
    <<-EOF
    grafana:
      adminPassword: admin
      fullnameOverride: grafana
      service:
        type: ClusterIP
    EOF
  ]
}
