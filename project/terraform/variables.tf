variable "subnet_id" {
  description = "Yandex VPC subnet_id"
  type        = string
}
variable "subdomai" {
  type = list(string)
  description = "Hostnames list"
}
variable "dns-domain" {
  type = string
  description = "DNS zone"
}