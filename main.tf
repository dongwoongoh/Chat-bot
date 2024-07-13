terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_network" "src" {
  name = "mad"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
  depends_on   = [docker_network.src]
}

resource "docker_image" "psql" {
  name         = "postgres:14.12"
  keep_locally = false
  depends_on   = [docker_image.nginx]
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "web-server"
  ports {
    internal = 80
    external = 80
    protocol = "tcp"
  }
  networks_advanced {
    name = docker_network.src.name
  }
  cpu_shares = 512
  memory     = 512
  restart    = "always"
  depends_on = [docker_image.nginx]
}

resource "docker_container" "db" {
  image = docker_image.psql.image_id
  name  = "database"
  ports {
    internal = 5432
    external = 5432
    protocol = "tcp"
  }
  networks_advanced {
    name = docker_network.src.name
  }
  cpu_shares = 1024
  memory     = 1024
  env        = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]
  restart    = "always"
  depends_on = [docker_image.psql]
}
