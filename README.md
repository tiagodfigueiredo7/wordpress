# Projeto - WORDPRESS DIGITAL OCEAN
[![NPM](https://img.shields.io/npm/l/react)](https://github.com/tiagodfigueiredo7/awsterralt/blob/main/LICENCE) 

# Sobre o projeto

> Nesse projeto vamos implementar o WordPress utilizando a Digital Ocean e algumas ferramentas como Terraform e Kubernetes







##  Projeto 

![Web 1](https://github.com/tiagodfigueiredo7/assets/blob/main/Projeto%209/ScreenHunter%201934.png)

 
  



# Tecnologias utilizadas

- Digital Ocean
- Kubernetes
- GitHub
- WordPress
- Terraform
- Vscode


## Parte 1 - Como executar o projeto



- Pré-requisitos: Conta Digital Ocean



## Parte 2 - Token Digital Ocean





![Web 1](https://github.com/tiagodfigueiredo7/assets/blob/main/Projeto%209/ScreenHunter%201880.png)
![Web 1](https://github.com/tiagodfigueiredo7/assets/blob/main/Projeto%209/ScreenHunter%201925.png)



> Vamos dar um Export no Token :


```
export TOKEN="dop_v1_f916596b--------------------------------------"

```

## Parte 3 - Terraform 


provider.tf

```

variable "digitalocean_token" {
  default = "dop_v1_f916596b52db---------------------------------"
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

```


- main.fg

```
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



```
- output.tf


```
resource "local_file" "kubernetes_config" {
  content = "${digitalocean_kubernetes_cluster.tiagofigueiredo.kube_config.0.raw_config}"
  filename = "kubeconfig.yaml"
}

```
- loadblancer.tf

```
resource "digitalocean_loadbalancer" "public" {
  name = "loadbalancer-1"
  region = "nyc1"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 30000
    target_protocol = "http"
  }

  healthcheck {
    port = 30000
    protocol = "tcp"
  }

  droplet_tag = "tiagofigueiredo"
}

```
- dns.tf

```
# Criando novo dominio

resource "digitalocean_domain" "tiagodfig7" {
  name = "tiagodfig7.com"
}

# Add a record to the domain
resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.tiagodfig7.name}"
  type   = "A"
  name   = "www"
  ttl    = "30"
  value  = "${digitalocean_loadbalancer.public.ip}"
}
```





## Parte 3  - Acessando o Cluster Kubernetes 

Faça dowload do Arquivo com as informações do kube.conf  coloque na home e execute o comando a baixo: 

```
mv tiagofigueiredo-kubeconfig.yaml .kube/config

```


## Parte 4 - Agora que temos acesso ao cluster vamos aplicar os arquivos de dentro da pasta Kubernetes

1°

```
k apply -f 01-mysql-pvc.yaml       

```

2°

```
k apply -f 02-mysql-deployment.yaml         

```

3°

```
k apply -f 03-wordpress-deployment.yaml       

```

## Parte 5 - Acessando 


![Web 1](https://github.com/tiagodfigueiredo7/assets/blob/main/Projeto%209/ScreenHunter%201938.png)

![Web 1](https://github.com/tiagodfigueiredo7/assets/blob/main/Projeto%209/ScreenHunter%201939.png)










# Autor

Tiago Domingos Figueiredo 

https://www.linkedin.com/in/tiagodfigueiredo/


![Web 1](https://github.com/tiagodfigueiredo7/assets/blob/main/t.jpg)
![Web 1](https://github.com/tiagodfigueiredo7/assets/blob/main/Projeto%209/ScreenHunter%201940.png)

