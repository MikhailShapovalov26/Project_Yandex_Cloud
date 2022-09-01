# output "external_ip" {
#   value = [yandex_compute_instance.wp-mysql-web[*].network_interface[*].nat_ip_address]
# }
# output "external_ip_address_proxy" {
#   value = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"
# }
# output "internal_ip_address_proxy" {
#   value = "${yandex_compute_instance.proxy.network_interface.0.ip_address}"
# }
