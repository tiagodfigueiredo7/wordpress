resource "digitalocean_kubernetes_cluster" "tiagofigueiredo" {
  name    = "tiagofigueiredo"
  region  = "nyc1"
  version = "1.22.13-do.0"

  node_pool {
    name       = "tiagofigueiredo"
    size       = "s-1vcpu-2gb"
    node_count = 1
    tags = ["tiagofigueiredo"]
  }
}
