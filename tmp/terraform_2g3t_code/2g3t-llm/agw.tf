module "agw" {
  source               = "../modules/agw"
  resource_group_name  = var.resource_group_name
  location             = var.location
  agw_name = var.agw_name
  waf_name = var.waf_name
  allow_ip_waf = var.allow_ip_waf
  waf_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/${var.waf_name}"
  pip_id_waf = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/publicIPAddresses/${var.pip_agw_name}"
  subnet_id_agw = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.snet_agw_name}"
  backend_pool_name = var.backend_pool_name
  affinity_name_443 = var.affinity_name_443
  affinity_name_80 = var.affinity_name_80
  backend_name_443 = var.backend_name_443
  backend_name_80 = var.backend_name_80
  backend_lister_name_443 = var.backend_lister_name_443
  backend_lister_name_80 = var.backend_lister_name_80
  ssl_certificate_name = var.ssl_certificate_name
  ssl_certificate_data = var.ssl_certificate_data
  ssl_certificate_password = var.ssl_certificate_password
  backend_route_name_443 = var.backend_route_name_443
  backend_route_name_80 = var.backend_route_name_80
  backend_address_pool_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/applicationGateways/${var.agw_name}/backendAddressPools/${var.backend_pool_name}"
  nic_web_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/networkInterfaces/${var.nic_web_name}"
  depends_on = [ module.vnet, module.vm ]
}
