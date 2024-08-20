output "resource_group" {
  value = azurerm_resource_group.main
}

output "resource_group_network_watcher" {
  value = azurerm_resource_group.rg_watcher
}

output "network_watcher" {
  value = azurerm_network_watcher.nw_watcher
}