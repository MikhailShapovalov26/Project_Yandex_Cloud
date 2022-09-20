resource "yandex_compute_instance" "gitlab_msh762" {
  platform_id = local.web_instance_type_map[terraform.workspace]
  name        = local.web_name_gitlab[terraform.workspace]
  hostname    = local.web_name_gitlab[terraform.workspace]
  zone        = "ru-central1-a"

  resources {
    memory        = 4
    cores         = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image-type.id
      size     = "20"
    }
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.default-nat.id
    nat        = false
    ip_address = "192.168.120.12"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  scheduling_policy {
    preemptible = true
  }
}