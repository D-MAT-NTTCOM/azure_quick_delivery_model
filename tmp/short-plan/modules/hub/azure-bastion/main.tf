# NSG / https://docs.microsoft.com/ja-jp/azure/bastion/bastion-nsg
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-azurebastion-001"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "ingress-rule-1" {
  name                        = "AllowHttpsInbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443", ]
  source_address_prefix       = var.nsg_public_source_ips == null ? "Internet" : null #publicIPが指定されていない場合Internetを入力する。されている場合prefixesへ代入する
  source_address_prefixes     = var.nsg_public_source_ips == null ? null : var.nsg_public_source_ips #publicIPが指定されていない場合、代入しない。されている場合代入を行う。
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ingress-rule-2" {
  name                        = "AllowGatewayManagerInbound"
  priority                    = 1010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443", ]
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ingress-rule-3" {
  name                        = "AllowAzureLoadBalancerInbound"
  priority                    = 1020
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443", ]
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ingress-rule-4" {
  name                        = "AllowBastionHostCommunicationInbound"
  priority                    = 1030
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701", ]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


resource "azurerm_network_security_rule" "ingress-rule-deny" {
  name                        = "DenyAllInbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "egress-rule-1" {
  name                        = "AllowSshRdpOutbound"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["22", "3389", ]
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "egress-rule-2" {
  name                        = "AllowAzureCloudOutbound"
  priority                    = 1010
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443", ]
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "egress-rule-3" {
  name                        = "AllowBastionHostCommunicationOutbound"
  priority                    = 1020
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["8080", "5701", ]
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "egress-rule-4" {
  name                        = "AllowGetSessionInfomation"
  priority                    = 1030
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80", ]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "egress-rule-deny" {
  name                        = "DenyAllOutbound"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

#上で作成したNSGルールをサブネットへ適用する
resource "azurerm_subnet_network_security_group_association" "nsg" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [
    azurerm_network_security_rule.ingress-rule-1,
    azurerm_network_security_rule.ingress-rule-2,
    azurerm_network_security_rule.ingress-rule-3,
    azurerm_network_security_rule.ingress-rule-4,
    azurerm_network_security_rule.ingress-rule-deny,
    azurerm_network_security_rule.egress-rule-1,
    azurerm_network_security_rule.egress-rule-2,
    azurerm_network_security_rule.egress-rule-3,
    azurerm_network_security_rule.egress-rule-4,
    azurerm_network_security_rule.egress-rule-deny,
  ]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host
# PublicIPの発行を実施し"pip-bas-ロケーション名-001"と命名する。
resource "azurerm_public_ip" "main" {
  name                = "pip-bas-${var.location}-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "main" {
  name                = var.hostname
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  copy_paste_enabled  = var.copy_paste_enabled
  file_copy_enabled   = var.sku == "Basic" ? null : var.file_copy_enabled # SKUがBasicの際には使用不可のためnull処理を実施
  scale_units         = var.sku == "Basic" ? null : var.scale_units # SKUがBasicの際には使用不可のためnull処理を実施

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.main.id
  }
  depends_on = [
    azurerm_subnet_network_security_group_association.nsg,
  ]
}

