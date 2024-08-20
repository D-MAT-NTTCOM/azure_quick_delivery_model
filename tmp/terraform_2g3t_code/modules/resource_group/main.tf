# Resource Group の作成
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# NSG Flow Logs
resource "azurerm_resource_group" "rg_watcher" {
  name     = "NetworkWatcherRG"
  location = var.location
}

resource "azurerm_network_watcher" "nw_watcher" {
  location            = var.location
  name                = "NetworkWatcher_${var.location}"
  resource_group_name = "NetworkWatcherRG"
  depends_on = [ azurerm_resource_group.rg_watcher ]
}