resource "azurerm_network_security_group" "nsg-agw" {
  name                = var.nsg_agw_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# 受信ルール
resource "azurerm_network_security_rule" "nsg-agw-rule-in-01" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "65200-65535"
  direction                   = "Inbound"
  name                        = "AllowGatewayManagerInbound"
  network_security_group_name = var.nsg_agw_name
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "GatewayManager"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-agw ]
}

resource "azurerm_network_security_rule" "nsg-agw-rule-in-02" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_ranges      = ["80","443"]
  direction                   = "Inbound"
  name                        = "AllowHttpHttpsInbound"
  network_security_group_name = var.nsg_agw_name
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = var.nsg_agw_ip_addr_customer
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-agw ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-association-agw" {
  subnet_id = var.subnet_id_agw
  network_security_group_id = azurerm_network_security_group.nsg-agw.id
}

