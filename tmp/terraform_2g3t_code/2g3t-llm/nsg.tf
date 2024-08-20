module "nsg-agw" {
  source = "../modules/nsg/agw"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  nsg_agw_name              = var.nsg_agw_name
  nsg_agw_ip_addr_customer  = var.nsg_agw_ip_addr_customer
  subnet_id_agw             = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.snet_agw_name}"
  depends_on = [ module.vnet, module.resource_group_main ]
}

module "nsg-bastion" {
  source = "../modules/nsg/bastion"
  resource_group_name  = var.resource_group_name
  location             = var.location
  nsg_bastion_name     = var.nsg_bastion_name
  nsg_bastion_ip_addr_maint = var.nsg_bastion_ip_addr_maint
  nsg_bastion_ip_addr_dev_01 = var.nsg_bastion_ip_addr_dev_01
  nsg_bastion_ip_addr_dev_02 = var.nsg_bastion_ip_addr_dev_02
  subnet_id_bastion             = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/AzureBastionSubnet"
  depends_on = [ module.vnet, module.resource_group_main]
}

module "nsg-llm" {
  source = "../modules/nsg/llm"
  resource_group_name  = var.resource_group_name
  location             = var.location
  nsg_llm_name         = var.nsg_llm_name
  subnets              = var.subnets
  subnet_id_llm             = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.snet_llm_name}"
  depends_on = [ module.vnet, module.resource_group_main]
}

module "nsg-web" {
  source = "../modules/nsg/web"
  resource_group_name  = var.resource_group_name
  location             = var.location
  nsg_web_name         = var.nsg_web_name
  subnets              = var.subnets
  subnet_id_web             = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.snet_web_name}"
  depends_on = [ module.vnet , module.resource_group_main]
}