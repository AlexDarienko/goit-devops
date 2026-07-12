
resource "kubernetes_namespace" "argocd" { metadata { name = "argocd" } }
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  version    = "6.7.11"
  values     = [file("${path.module}/values.yaml")]
}
resource "helm_release" "argocd_apps" {
  name       = "argocd-apps"
  chart      = "${path.module}/charts"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  depends_on = [helm_release.argocd]
}
