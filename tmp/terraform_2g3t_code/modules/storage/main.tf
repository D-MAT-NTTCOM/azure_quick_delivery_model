resource "azurerm_storage_account" "storage" {
  account_replication_type         = "LRS"
  account_tier                     = "Standard"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  location                         = var.location
  name                             = var.storage_account_name
  resource_group_name              = var.resource_group_name
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  container_delete_retention_policy {
    days = 7
    }
  }
  share_properties {
    retention_policy {
      days = 7
    }
  }
  
}

resource "azurerm_storage_management_policy" "lifecycle" {
  storage_account_id = azurerm_storage_account.storage.id

  rule {
    name    = "lifecyclepolicy-alllogs-move"
    enabled = true
    filters {
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_creation_greater_than = var.lifecycle_move_days
      }
    }
  }
  rule {
    name    = "lifecyclepolicy-alllogs-delete"
    enabled = true
    filters {
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_creation_greater_than = var.lifecycle_delete_days
      }
    }
  }
}