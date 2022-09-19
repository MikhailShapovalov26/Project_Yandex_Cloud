module "dns_zone" {
  source           = "../modules/yandex_dns_zone"
  for_each         = local.zones
  domain_name      = each.key
  records          = lookup(each.value, "records")
  public           = lookup(each.value, "public")
  zone_name        = lookup(each.value, "name")
  private_networks = lookup(each.value, "private_networks", null)
  # data = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"
}