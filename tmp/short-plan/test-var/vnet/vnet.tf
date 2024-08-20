# VNET と Subnet の管理
module "vnet" {
  source               = "../../modules/hub/vnet/"
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space
  subnets              = var.subnets
}

# Peering 向け情報表示
output "virtual_network_name" {
  value = var.virtual_network_name
}

# Peering 向け情報表示
output "virtual_network_id" {
  value = module.vnet.virtual_network_id
}

# subnet 情報出力
output "subnets" {
  value = module.vnet.subnets
}

# VPN でのローカル環境接続
module "onprem-vpn-gateway" {
  source = "../../modules/hub/vnet/onprem-vpn-gateway"

  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.vnet.subnets["GatewaySubnet"].id

  vpn_name = var.vpn_name

  onprem_public_ip = var.onprem_public_ip
  shared_key       = var.shared_key # openssl rand -base64 24

  onprem_network_subnets_list = [
    var.onprem_bgp_neighbor_subnet,
  ]
  onprem_asn               = var.onprem_asn
  onprem_bgp_neighbor_addr = var.onprem_bgp_neighbor_addr

  bgp_asn = var.bgp_asn
}

# VPN アドレス
output "onprem-vpn-azure-public-ip-address" {
  value = module.onprem-vpn-gateway.onprem-vpn-azure-public-ip-address
}

# VPN Config 例表示
output "onprem-edgerouterx-example-config" {
  value = module.onprem-vpn-gateway.onprem-edgerouterx-example-config
}

output "azure-bgp-router-ip" {
  value = module.onprem-vpn-gateway.azure-bgp-router-ip
}


# Spoke との Peering
## ./spoke_peering/ に別記載

# Azure Firewall
## ../firewall/ に別記載
