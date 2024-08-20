module "vm" {
  source               = "../modules/vm"
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space
  subnets              = var.subnets
  admin_username = "azureuser"

  ##llm
  vm_llm_name = var.vm_llm_name
  nic_llm_name = var.nic_llm_name
  disk_llm_size = var.disk_llm_size
  subnet_id_llm = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.snet_llm_name}"
  public_key_llm = var.public_key_llm
  private_ip_llm = var.private_ip_llm

  ##web
  vm_web_name = var.vm_web_name
  nic_web_name = var.nic_web_name
  disk_web_size = var.disk_web_size
  subnet_id_web = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.snet_web_name}"
  public_key_web = var.public_key_web
  private_ip_web = var.private_ip_web

  depends_on = [module.vnet, module.resource_group_main]
}