locals {
  Foo =  "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"
    zones = {
    "msh762.ru" = {
      name   = "msh762-ru-zone",
      public = true,
      records = [
        { name = "", type = "A", ttl = 200, records = [local.Foo,]},
        { name = "www", type = "CNAME", ttl = 200, records = ["msh762.ru."]},
        { name = "gitlab", type = "CNAME", ttl = 200, records = ["msh762.ru."] },
        { name = "grafana", type = "CNAME", ttl = 200, records = ["msh762.ru."] },
        { name = "prometheus", type = "CNAME", ttl = 200, records = ["msh762.ru."] },
        { name = "alertmanager", type = "CNAME", ttl = 200, records = ["msh762.ru."] },
      ]
    }
  }
  env = terraform.workspace
  web_instance_type_map = {
    stage = "standard-v1"
    prod  = "standard-v1"
  }
  web_count_map = {
    stage = 1
    prod  = 1
  }

  count = lookup(local.web_count_map, local.env)

  name_db01_instance = {
    stage = "db-master-01"
    prod  = "db-master-01"
  }
  name_db02_instance = {
    stage = "db-slave-01"
    prod  = "db-slave-01"
  }
  web_memory_map = {
    stage = 2
    prod  = 2
  }
  web_name_map_nginx = {
    stage = "proxy-msh762-s"
    prod  = "proxy-msh762"
  }
  web_name_map_bd = {
    stage = "db01-msh762-s"
    prod  = "db01-msh762"
  }
  web_name_wordpress = {
    stage = "msh762-s"
    prod  = "msh762"
  }
  web_name_gitlab = {
    stage = "gitlab-msh762-s"
    prod  = "gitlab-msh762"
  }
  web_name_runner = {
    stage = "runner-msh762-s"
    prod  = "runner-msh762"
  }
  web_name_monitoring = {
    stage = "monitoring-msh762-s"
    prod  = "monitoring-msh762"
  }

  mysql_environment_bd = {
    stage = "PRESTABLE"
    prod  = "PRODUCTION"
  }
  mysql_deletion_protection = {
    stage = false
    prod  = false
  }
}