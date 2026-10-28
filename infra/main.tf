resource "kind_cluster" "this" {
  name           = "plateforme"
  wait_for_ready = true
}

# --- Connexion du provider Helm au cluster kind (syntaxe v3 : kubernetes = { ... }) ---
provider "helm" {
  kubernetes = {
    host                   = kind_cluster.this.endpoint
    client_certificate     = kind_cluster.this.client_certificate
    client_key             = kind_cluster.this.client_key
    cluster_ca_certificate = kind_cluster.this.cluster_ca_certificate
  }
}

# --- ArgoCD via son chart Helm ---
resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "10.10.3"
  timeout          = 600
}
