output "grafana_url" {
  value = "Run 'kubectl port-forward svc/grafana 3000:80 -n monitoring'"
}
