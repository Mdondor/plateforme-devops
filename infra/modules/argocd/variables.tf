variable "version_chart" {
  description = "Version du chart Helm argo-cd"
  type        = string
}

variable "depot" {
  description = "URL HTTPS publique du dépôt Git surveillé par ArgoCD"
  type        = string
}
