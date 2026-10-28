# --- Le cluster kind (module) ---
module "cluster" {
  source = "./modules/cluster"
  nom    = var.nom_cluster
}

# --- Connexion du provider Helm au cluster créé par le module ---
provider "helm" {
  kubernetes = {
    host                   = module.cluster.endpoint
    client_certificate     = module.cluster.client_certificate
    client_key             = module.cluster.client_key
    cluster_ca_certificate = module.cluster.cluster_ca_certificate
  }
}

# --- ArgoCD + application racine (module) ---
module "argocd" {
  source        = "./modules/argocd"
  version_chart = var.version_argocd
  depot         = var.depot

  depends_on = [module.cluster]
}
