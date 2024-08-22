provider "azurerm" {
  subscription_id = var.provider_credentials.subscription_id
  tenant_id       = var.provider_credentials.tenant_id
  client_id       = var.provider_credentials.sp_client_id
  client_secret   = var.provider_credentials.sp_client_secret
  features {}
}

locals {
  resource_group_name       = "d-mat-02-rg"
  storage_account_diag_name = "dmatdiag20240822"
}

resource "azurerm_resource_group" "je" {
  name     = local.resource_group_name
  location = var.location
  tags = {
    owner = "d-mat"
  }
}

# 診断ログの保管ストレージ
resource "azurerm_storage_account" "diag" {
  name                     = local.storage_account_diag_name
  resource_group_name      = azurerm_resource_group.je.name
  location                 = azurerm_resource_group.je.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    owner = "d-mat"
  }
}