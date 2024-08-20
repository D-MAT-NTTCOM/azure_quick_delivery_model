module "bastion" {
  source               = "../modules/bastion"
  resource_group_name  = var.resource_group_name
  location             = var.location
  bastion_name = var.bastion_name
  pip_bastion_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/publicIPAddresses/${var.pip_bastion_name}"
  subnet_id_bastion = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/AzureBastionSubnet"
  depends_on = [ module.vnet ]
}