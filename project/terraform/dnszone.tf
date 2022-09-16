resource "yandex_dns_zone" "zone1" {
  name        = "my-public-zone"

  labels = {
    label1 = "msh762.ru"
  }

  zone    = "msh762.ru."
  public  = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "msh762.ru."
  type    = "A"
  ttl     = 200
  data    = ["10.1.0.1"]
}
