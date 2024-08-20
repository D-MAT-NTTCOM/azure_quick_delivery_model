resource "azurerm_network_security_group" "nsg-web" {
  name                = var.nsg_web_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

#受信ルール
resource "azurerm_network_security_rule" "nsg-web-rule-in-01" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["22", "3389"]
  direction                   = "Inbound"
  name                        = "AllowBastionInBound"
  network_security_group_name = var.nsg_web_name
  priority                    = 100
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = var.subnets["AzureBastionSubnet"]["address_prefix"]
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-web ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-web" {
  subnet_id = var.subnet_id_web
  network_security_group_id = azurerm_network_security_group.nsg-web.id
}
