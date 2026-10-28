resource "kind_cluster" "this" {
  name           = "plateforme"
  wait_for_ready = true
}
