# VNET と Subnet の管理
module "vnet" {
  source               = "../modules/vnet"
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space
  subnets              = var.subnets
  pip_bastion_name = var.pip_bastion_name
  pip_agw_name = var.pip_agw_name
  depends_on = [ module.resource_group_main, module.resource_group_market]
}

