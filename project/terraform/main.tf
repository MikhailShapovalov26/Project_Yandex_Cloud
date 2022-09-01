provider "yandex" {
  zone = "ru-central1-a"
}
data "yandex_compute_image" "image-type" {
  family = "ubuntu-2004-lts"
}
data "yandex_compute_image" "nat-image" {
  family = "nat-instance-ubuntu"
}