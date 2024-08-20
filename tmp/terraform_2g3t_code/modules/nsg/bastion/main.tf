resource "azurerm_network_security_group" "nsg-bastion" {
  name                = var.nsg_bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

#受信ルール
resource "azurerm_network_security_rule" "nsg-bastion-rule-in-01" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowGatewayManagerInBound"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "GatewayManager"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-in-02" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowLoadBalancerInBound"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "AzureLoadBalancer"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-in-03" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["5701", "8080"]
  direction                   = "Inbound"
  name                        = "AllowBastionHostCommunicationInBound"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 120
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-in-04" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowClientIPInbound-Maint"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 130
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = var.nsg_bastion_ip_addr_maint
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-in-05" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowClientIPInbound-dev-01"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 140
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = var.nsg_bastion_ip_addr_dev_01
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-in-in-06" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowClientIPInbound-dev-02"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 150
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = var.nsg_bastion_ip_addr_dev_02
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}


#送信ルール
resource "azurerm_network_security_rule" "nsg-bastion-rule-out-01" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["22", "3389"]
  direction                   = "Outbound"
  name                        = "AllowSshRdpOutBound"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-out-02" {
  access                      = "Allow"
  destination_address_prefix  = "AzureCloud"
  destination_port_range      = "443"
  direction                   = "Outbound"
  name                        = "AllowAzureCloudCommunicationOutBound"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-out-03" {
  access                      = "Allow"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["5701", "8080"]
  direction                   = "Outbound"
  name                        = "AllowBastionHostCommunicationOutBound"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 120
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "VirtualNetwork"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_network_security_rule" "nsg-bastion-rule-out-04" {
  access                      = "Allow"
  destination_address_prefix  = "Internet"
  destination_port_ranges     = ["443", "80"]
  direction                   = "Outbound"
  name                        = "AllowGetSessionInformationOutBound"
  network_security_group_name = var.nsg_bastion_name
  priority                    = 130
  protocol                    = "*"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [ azurerm_network_security_group.nsg-bastion ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-bastion" {
  subnet_id = var.subnet_id_bastion
  network_security_group_id = azurerm_network_security_group.nsg-bastion.id
}

