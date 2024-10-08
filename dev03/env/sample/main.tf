################################################################################
## 共通ディレクトリの変数に代入
################################################################################

provider "azurerm" {
  features {}
  subscription_id = local.login.subscription_id
  tenant_id       = local.login.tenant_id
}

module "main" {
  source = "../../"

  resource_group            = local.resource_group
  virtual_network           = local.virtual_network
  subnet                    = local.subnet
  public_ip                 = local.public_ip
  availability_set          = local.availability_set
  storage_account           = local.storage_account
  recovery_services_vault   = local.recovery_services_vault
  backup_policy_vm_daily    = local.backup_policy_vm_daily
  backup_policy_vm_weekly   = local.backup_policy_vm_weekly
  proximity_placement_group = local.proximity_placement_group
  backup_storage_account    = local.backup_storage_account
}
