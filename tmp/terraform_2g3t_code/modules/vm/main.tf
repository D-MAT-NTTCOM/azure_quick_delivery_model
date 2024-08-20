resource "azurerm_network_interface" "nic_llm" {
  enable_accelerated_networking = true
  location                      = var.location
  name                          = var.nic_llm_name
  resource_group_name           = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id_llm
    private_ip_address_allocation = "Static"
    private_ip_address = var.private_ip_llm
  }
  
}

resource "azurerm_network_interface" "nic_web" {
  enable_accelerated_networking = true
  location                      = var.location
  name                          = var.nic_web_name
  resource_group_name           = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id_web
    private_ip_address_allocation = "Static"
    private_ip_address = var.private_ip_web
  }
}

#ssh_key登録
##llm
resource "azurerm_ssh_public_key" "key_llm" {
  location            = var.location
  name                = "${var.vm_llm_name}-${var.admin_username}-key"
  public_key          = var.public_key_llm
  resource_group_name = var.resource_group_name
}

resource "azurerm_ssh_public_key" "key_web" {
  location            = var.location
  name                = "${var.vm_web_name}-${var.admin_username}-key"
  public_key          = var.public_key_web
  resource_group_name = var.resource_group_name
}

#llm用vm作成
resource "azurerm_linux_virtual_machine" "vm_llm" {
  admin_username        = var.admin_username
  location              = var.location
  name                  = var.vm_llm_name
  network_interface_ids = azurerm_network_interface.nic_llm.*.id
  patch_mode            = "AutomaticByPlatform"
  reboot_setting        = "IfRequired"
  resource_group_name   = var.resource_group_name
  size                  = "Standard_NC4as_T4_v3"
  vtpm_enabled          = true
  additional_capabilities {
  }
  admin_ssh_key {
    public_key = var.public_key_llm
    username   = var.admin_username
  }
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb = var.disk_llm_size
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "canonical"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.nic_llm,
  ]
}

#web用vm作成
resource "azurerm_linux_virtual_machine" "vm_web" {
  admin_username        = var.admin_username
  location              = var.location
  name                  = var.vm_web_name
  network_interface_ids = azurerm_network_interface.nic_web.*.id
  patch_mode            = "AutomaticByPlatform"
  reboot_setting        = "IfRequired"
  resource_group_name   = var.resource_group_name
  size                  = "Standard_NC4as_T4_v3"
  vtpm_enabled          = true
  additional_capabilities {
  }
  admin_ssh_key {
    public_key = var.public_key_web
    username   = var.admin_username
  }
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb = var.disk_web_size
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "canonical"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.nic_web,
  ]
}

###以下コードにて秘密鍵の生成は可能だが、.tfstateファイルに秘密鍵が残るリスクがあり、危険なため無効化し、web上またはローカルにて生成し、公開鍵をアップロード・格納するのを推奨
#秘密鍵と公開鍵の作成、実行後以下コマンドを実行
#terraform output -raw tls_private_key_llm > key_llm.pem
# resource "tls_private_key" "key_llm" {
#   algorithm = "RSA"
#   rsa_bits = 4096
# }
# output "tls_private_key_llm" { 
#     value = tls_private_key.key_llm.private_key_pem 
#     sensitive = true
# }

#秘密鍵と公開鍵の作成、実行後以下コマンドを実行
#terraform output -raw tls_private_key_web > key_web.pem
# resource "tls_private_key" "key_web" {
#   algorithm = "RSA"
#   rsa_bits = 4096
# }
# output "tls_private_key_web" { 
#     value = tls_private_key.key_web.private_key_pem 
#     sensitive = true
# }