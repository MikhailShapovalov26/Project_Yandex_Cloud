resource "yandex_compute_instance" "runner" {
  platform_id = local.web_instance_type_map[terraform.workspace]
  name        = local.web_name_runner[terraform.workspace]
  hostname    = local.web_name_runner[terraform.workspace]
  zone        = "ru-central1-a"

  resources {
    memory        = local.web_memory_map[terraform.workspace]
    cores         = local.web_memory_map[terraform.workspace]
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image-type.id
      size     = "10"
    }
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.default-nat.id
    nat        = false
    ip_address = "192.168.120.13"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  scheduling_policy {
    preemptible = true
  }

}