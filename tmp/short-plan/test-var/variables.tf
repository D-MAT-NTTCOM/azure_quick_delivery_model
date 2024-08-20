variable "resource_group_name" {}

variable "location" {
  type    = string
  default = "japaneast"
}

# bastion
variable "hostname" {}

variable "subnet_id" {}

variable "allow_ingress_public_source_ips" {
  type    = list(string)
  default = null
}
