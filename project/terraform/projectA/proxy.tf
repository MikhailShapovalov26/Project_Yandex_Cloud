resource "yandex_compute_instance" "proxy" {
  platform_id = local.web_instance_type_map[terraform.workspace]
  name        = local.web_name_map_nginx[terraform.workspace]
  hostname    = local.web_name_map_nginx[terraform.workspace]
  zone        = "ru-central1-a"
  resources {
    cores         = local.web_memory_map[terraform.workspace]
    memory        = local.web_memory_map[terraform.workspace]
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat-image.id
      size     = "10"
    }
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.default.id
    nat        = true
    ip_address = "192.168.100.10"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  scheduling_policy {
    preemptible = true
  }
}