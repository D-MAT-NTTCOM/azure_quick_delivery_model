resource "azurerm_bastion_host" "azure_bastion" {
  location            = var.location
  name                = var.bastion_name
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tunneling_enabled   = true
  scale_units = 2
  copy_paste_enabled = true
  ip_configuration {
    name                 = "IpConf"
    public_ip_address_id = var.pip_bastion_id
    subnet_id            = var.subnet_id_bastion
  }
}