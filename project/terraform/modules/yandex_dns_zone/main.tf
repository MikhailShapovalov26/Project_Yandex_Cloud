locals {
  records    = concat(var.records, try(jsondecode(var.records_jsonencoded), []))
  recordsets = { for rs in local.records : try(rs.key, join(" ", compact(["${rs.name} ${rs.type}", try(rs.set_identifier, "")]))) => rs }
}

resource "yandex_dns_zone" "dns_zone" {
  private_networks = var.public != true ? var.private_networks : null
  zone             = "${var.domain_name}."
  name             = var.zone_name
  public           = var.public
}

resource "yandex_dns_recordset" "records" {
  for_each = { for k, v in local.recordsets : k => v }
  name     = each.value.name != "" ? each.value.name : "${var.domain_name}."
  data     = try(each.value.records)
  ttl      = try(each.value.ttl, null)
  zone_id  = yandex_dns_zone.dns_zone.id
  type     = each.value.type
}