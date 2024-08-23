################################################################################
## リソースグループの作成
################################################################################
resource "azurerm_resource_group" "main" {
  for_each = var.resource_group
  name     = each.value.name
  location = each.value.location
}

output "resource_group" {
  value = azurerm_resource_group.main
}
