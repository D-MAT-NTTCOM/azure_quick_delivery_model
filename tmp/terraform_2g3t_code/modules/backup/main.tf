#Create Backup Container
resource "azurerm_recovery_services_vault" "bu-container" {
  location            = var.location
  name                = var.backup_container_name
  resource_group_name = var.resource_group_name
  sku                 = "RS0"
  storage_mode_type   = "LocallyRedundant"
}

#Backup Policy main
resource "azurerm_backup_policy_vm" "bp-vm" {
  name                = var.backup_policy_name
  policy_type         = "V2"
  recovery_vault_name = var.backup_container_name
  resource_group_name = var.resource_group_name
  timezone            = "Tokyo Standard Time"
  backup {
    frequency = "Daily"
    time      = "00:00"
  }
  retention_daily {
    count = 30
  }
  depends_on = [
    azurerm_recovery_services_vault.bu-container,
  ]
}