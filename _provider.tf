variable "digitalocean_token" {
  default = "dop_v1_f916596b52db92dcfa3c358027ad2cda71554763aa4d75a71c6335a22e6c75b2"
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}