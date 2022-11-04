# Creamos un dominio nuevo

resource "digitalocean_domain" "tiagodfig7" {
  name = "tiagodfig7.com"
}

# Add a record to the domain
resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.tiagodfig7.com.name}"
  type   = "A"
  name   = "www"
  ttl    = "30"
  value  = "${digitalocean_loadbalancer.public.ip}"
}