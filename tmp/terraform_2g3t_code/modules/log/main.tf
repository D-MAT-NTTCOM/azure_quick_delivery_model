#フローログ用
resource "azurerm_log_analytics_workspace" "azurerm_log_analytics_workspace" {
  location            = var.location
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
  retention_in_days = 30
}

resource "azurerm_network_watcher_flow_log" "bastion" {
  enabled                   = true
  name                      = "${var.nsg_bastion_name}-${var.resource_group_name}-flowlog"
  network_security_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_bastion_name}"
  network_watcher_name      = var.network_watcher.name
  resource_group_name       = "NetworkWatcherRG"
  storage_account_id        = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.strage_account_name}"
  retention_policy {
    days    = 0
    enabled = false
  }
  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.workspace_id
    workspace_region      = var.location
    workspace_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_analytics_workspace_name}"
  }
}

resource "azurerm_network_watcher_flow_log" "agw" {
  enabled                   = true
  name                      = "${var.nsg_agw_name}-${var.resource_group_name}-flowlog"
  network_security_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_agw_name}"
  network_watcher_name      = var.network_watcher.name
  resource_group_name       = "NetworkWatcherRG"
  storage_account_id        = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.strage_account_name}"
  retention_policy {
    days    = 0
    enabled = false
  }
  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.workspace_id
    workspace_region      = var.location
    workspace_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_analytics_workspace_name}"
  }
}

resource "azurerm_network_watcher_flow_log" "web" {
  enabled                   = true
  name                      = "${var.nsg_web_name}-${var.resource_group_name}-flowlog"
  network_security_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_web_name}"
  network_watcher_name      = var.network_watcher.name
  resource_group_name       = "NetworkWatcherRG"
  storage_account_id        = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.strage_account_name}"
  retention_policy {
    days    = 0
    enabled = false
  }
  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.workspace_id
    workspace_region      = var.location
    workspace_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_analytics_workspace_name}"
  }
}

resource "azurerm_network_watcher_flow_log" "llm" {
  enabled                   = true
  name                      = "${var.nsg_llm_name}-${var.resource_group_name}-flowlog"
  network_security_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_llm_name}"
  network_watcher_name      = var.network_watcher.name
  resource_group_name       = "NetworkWatcherRG"
  storage_account_id        = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.strage_account_name}"
  retention_policy {
    days    = 0
    enabled = false
  }
  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.workspace_id
    workspace_region      = var.location
    workspace_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_analytics_workspace_name}"
  }
}


#Entra ID log
resource "azurerm_monitor_aad_diagnostic_setting" "entra_log" {
  name = var.entra_diagnostic_setting_name
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.strage_account_name}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.id
  enabled_log {
    category = "AuditLogs"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "SignInLogs"
      retention_policy {
          days    = 0
          enabled = false
      }
  }
  enabled_log {
    category = "NonInteractiveUserSignInLogs"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "ServicePrincipalSignInLogs"
      retention_policy {
          days    = 0
          enabled = false
      }
  }
  enabled_log {
    category = "ADFSSignInLogs"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "RiskyUsers"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "UserRiskEvents"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "NetworkAccessTrafficLogs"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "RiskyServicePrincipals"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "ServicePrincipalRiskEvents"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "EnrichedOffice365AuditLogs"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "MicrosoftGraphActivityLogs"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
  enabled_log {
    category = "RemoteNetworkHealthLogs"
    retention_policy {
        days    = 0
        enabled = false
    }
  }
}

#Activity log
resource "azurerm_monitor_diagnostic_setting" "activity_log" {
  name = var.activity_diagnostic_setting_name
  target_resource_id = "/subscriptions/${var.subscription_id}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.id
  storage_account_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${var.strage_account_name}"
  enabled_log {
    category = "Administrative"
  }
  enabled_log {
    category = "Security"
  }
  enabled_log {
    category = "ServiceHealth"
  }
  enabled_log {
    category = "Alert"
  }
  enabled_log {
    category = "Recommendation"
  }
  enabled_log {
    category = "Policy"
  }
  enabled_log {
    category = "Autoscale"
  }
  enabled_log {
    category = "ResourceHealth"
  }
}

#VM Performance counter
resource "azurerm_monitor_data_collection_rule" "performance_counter" {
  description         = "Data collection rule for VM Insights."
  location            = var.location
  name                = var.dcr_performance_counter_name
  resource_group_name = var.resource_group_name
  data_flow {
    destinations = ["VMInsightsPerf-Logs-Dest"]
    streams      = ["Microsoft-InsightsMetrics"]
  }
  data_sources {
    performance_counter {
      counter_specifiers            = ["\\VmInsights\\DetailedMetrics"]
      name                          = "VMInsightsPerfCounters"
      sampling_frequency_in_seconds = 60
      streams                       = ["Microsoft-InsightsMetrics"]
    }
  }
  destinations {
    log_analytics {
      name                  = "VMInsightsPerf-Logs-Dest"
      workspace_resource_id = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.id
    }
  }
  depends_on = [
    azurerm_log_analytics_workspace.azurerm_log_analytics_workspace,
  ]
}


resource "azurerm_monitor_data_collection_rule" "syslog" {
  kind                = "Linux"
  location            = var.location
  name                = var.dcr_vm_syslog_name
  resource_group_name = var.resource_group_name
  data_flow {
    destinations  = [var.dcr_vm_syslog_distination_name]
    output_stream = "Microsoft-Syslog"
    streams       = ["Microsoft-Syslog"]
    transform_kql = "source"
  }
  data_sources {
    syslog {
      facility_names = ["*"]
      log_levels     = ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
      name           = var.dcr_vm_syslog_source_name
    }
  }
  destinations {
    log_analytics {
      name                  = var.dcr_vm_syslog_distination_name
      workspace_resource_id = azurerm_log_analytics_workspace.azurerm_log_analytics_workspace.id
    }
  }
  depends_on = [
    azurerm_log_analytics_workspace.azurerm_log_analytics_workspace,
  ]
}

resource "azurerm_monitor_data_collection_rule_association" "llm-01" {
  name = "vm-association-llm-01"
  target_resource_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.compute/virtualmachines/${var.vm_llm_name}"
  data_collection_rule_id = azurerm_monitor_data_collection_rule.syslog.id
  depends_on = [
    azurerm_monitor_data_collection_rule.syslog,
  ]
}

resource "azurerm_monitor_data_collection_rule_association" "web-01" {
  name = "vm-association-web-01"
  target_resource_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.compute/virtualmachines/${var.vm_web_name}"
  data_collection_rule_id = azurerm_monitor_data_collection_rule.syslog.id
  depends_on = [
    azurerm_monitor_data_collection_rule.syslog,
  ]
}
