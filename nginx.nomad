job "raumberger.dev" {
  datacenters = ["homenet"]
  type        = "service"

  constraint {
    distinct_hosts = true
  }

  constraint {
    attribute = "${node.class}"
    value = "storage"
  }

  constraint {
    attribute = "${attr.cpu.arch}"
    value     = "arm64"
  }

  group "web" {
    count = 2

    network {
      mode = "bridge"
      port "http" {
        to = 80
      }
    }

    reschedule {
      delay          = "30s"
      delay_function = "constant"
      unlimited      = true
    }

    resources {
      cpu    = 1000
      memory = 3000
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "registry.lab.raumberger.net/raumberger-dev:VERSION"
      }
    }

    service {
      name = "raumbergerDev"
      port = "http"
    }
  }
}
