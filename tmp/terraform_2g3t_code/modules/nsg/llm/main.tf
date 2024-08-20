resource "azurerm_network_security_group" "nsg-llm" {
  name                = var.nsg_llm_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

#受信ルール
resource "azurerm_network_security_rule" "nsg-llm-rule-in-01" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["22", "3389"]
  direction                   = "Inbound"
  name                        = "AllowBastionInBound"
  network_security_group_name = var.nsg_llm_name
  priority                    = 100
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = var.subnets["AzureBastionSubnet"]["address_prefix"]
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-llm ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-llm" {
  subnet_id = var.subnet_id_llm
  network_security_group_id = azurerm_network_security_group.nsg-llm.id
}
