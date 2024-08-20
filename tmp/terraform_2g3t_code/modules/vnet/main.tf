# VNET の作成
resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

# Subnet の作成
resource "azurerm_subnet" "main" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value.address_prefix]
}

#Bastion用パブリックIPの作成
resource "azurerm_public_ip" "pip-bastion" {
  allocation_method = "Static"
  location = var.location
  name = var.pip_bastion_name
  resource_group_name = var.resource_group_name
  sku = "Standard"
  zones = ["1", "2", "3"] 
}

#Application Gateway用パブリックIPの作成
resource "azurerm_public_ip" "pip-agw" {
  allocation_method = "Static"
  location = var.location
  name = var.pip_agw_name
  resource_group_name = var.resource_group_name
  sku = "Standard"
  zones = ["1", "2", "3"] 
}