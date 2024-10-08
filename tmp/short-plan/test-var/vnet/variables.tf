variable "resource_group_name" {}

variable "location" {
  type    = string
  default = "japaneast"
}

variable "virtual_network_name" {}

variable "address_space" {}

variable "subnets" {}

variable "vpn_name" {}

variable "onprem_public_ip" {}

variable "shared_key" {}

variable "onprem_bgp_neighbor_subnet" {}

variable "onprem_asn" {}

variable "onprem_bgp_neighbor_addr" {}

variable "bgp_asn" {}


variable "route_table_name" {
  type    = string
  default = "route-tosubregion"
}
