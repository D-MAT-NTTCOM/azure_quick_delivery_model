resource "azurerm_monitor_action_group" "monitor_action" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_display_name
  email_receiver {
    email_address = var.action_group_email
    name          = "${var.action_group_email_name}_-EmailAction-"
  }
}

#Resouce health vm
resource "azurerm_monitor_activity_log_alert" "rh-vm" {
  description         = "Azure VM リソース正常性アラートを検知しました"
  name                = "Azure VM Resource Health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    category        = "ResourceHealth"
    resource_groups = [var.resource_group_name]
    resource_types  = ["microsoft.compute/virtualmachines"]
    statuses        = ["Active", "Resolved"]
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Recource health agw
resource "azurerm_monitor_activity_log_alert" "rh-agw" {
  description         = "Azure AGW リソース正常性アラートを検知しました"
  name                = "Azure AGW Resource Health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    category        = "ResourceHealth"
    resource_groups = [var.resource_group_name]
    resource_types  = ["microsoft.network/applicationgateways"]
    statuses        = ["Active", "Resolved"]
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Recource health bastion
resource "azurerm_monitor_activity_log_alert" "rh-bastion" {
  description         = "Azure Bastion リソース正常性アラートを検知しました"
  name                = "Azure Bastion Resource Health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    category = "ServiceHealth"
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Service health VM
resource "azurerm_monitor_activity_log_alert" "sh-vm" {
  description         = "Azure VM サービス正常性アラートを検知しました"
  name                = "Azure VM Service Health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    category        = "ServiceHealth"
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Service health AGW
resource "azurerm_monitor_activity_log_alert" "sh-agw" {
  description         = "Azure AGW サービス正常性アラートを検知しました"
  name                = "Azure AGW Service Health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    category        = "ServiceHealth"
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Service health Bastion
resource "azurerm_monitor_activity_log_alert" "sh-bastion" {
  description         = "Azure Bastion サービス正常性アラートを検知しました"
  name                = "Azure Bastion Service Health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    category = "ServiceHealth"
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Metric Alert VM CPU
resource "azurerm_monitor_metric_alert" "ma-vm-cpu" {
  description         = "CPUの使用率が80%を超過しました"
  name                = "AzureVM CPUAlert"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Compute/virtualMachines/${var.vm_llm_name}", "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/microsoft.compute/virtualMachines/${var.vm_web_name}"]
  severity            = 2
  target_resource_location = var.location
  target_resource_type = "microsoft.compute/virtualmachines"
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    aggregation      = "Average"
    metric_name      = "Percentage CPU"
    metric_namespace = "microsoft.compute/virtualmachines"
    operator         = "GreaterThan"
    threshold        = 80
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Metric Alert VM Memory
resource "azurerm_monitor_metric_alert" "ma-vm-memory" {
  description         = "使用可能なメモリ容量が80％を超過しました"
  name                = "AzureVM MemoryAlert"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Compute/virtualMachines/${var.vm_llm_name}", "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/microsoft.compute/virtualMachines/${var.vm_web_name}"]
  severity            = 2
  target_resource_location = var.location
  target_resource_type = "microsoft.compute/virtualmachines"
  action {
    action_group_id = "/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"
  }
  criteria {
    aggregation      = "Average"
    metric_name      = "Available Memory Bytes"
    metric_namespace = "microsoft.compute/virtualmachines"
    operator         = "LessThan"
    threshold        = 5600000000
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Log Alert
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "la-vm-disk" {
  auto_mitigation_enabled = true
  description             = "ディスク使用率が80%を超過しました。"
  display_name            = "AzureVM DiskAlert"
  evaluation_frequency    = "PT5M"
  location                = var.location
  name                    = "AzureVM DiskAlert"
  resource_group_name     = var.resource_group_name
  scopes                  = ["/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_analytics_workspace_name}"]
  severity                = 2
  target_resource_types   = ["Microsoft.OperationalInsights/workspaces"]
  window_duration         = "PT5M"
  action {
    action_groups = ["/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/microsoft.insights/actionGroups/${var.action_group_name}"]
  }
  criteria {
    metric_measure_column   = "AggregatedValue"
    operator                = "GreaterThanOrEqual"
    query                   = "InsightsMetrics\n| where Origin == \"vm.azm.ms\"\n| where Namespace == \"LogicalDisk\" and Name == \"FreeSpacePercentage\"\n| extend Disk=tostring(todynamic(Tags)[\"vm.azm.ms/mountId\"])\n| extend UsedSpacePercentage = 100 - Val\n| summarize AggregatedValue = avg(UsedSpacePercentage) by bin(TimeGenerated, 5m), Computer, Disk, _ResourceId\n"
    resource_id_column      = "_ResourceId"
    threshold               = 80
    time_aggregation_method = "Maximum"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}

#Heartbeat Alert
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "res-640" {
  auto_mitigation_enabled   = true
  description               = "Azure VMよりハートビート応答が無くなりました"
  display_name              = "Azure VM Heartbeat"
  evaluation_frequency      = "PT1M"
  location                  = var.location
  name                      = "Azure VM Heartbeat"
  query_time_range_override = "P2D"
  resource_group_name       = var.resource_group_name
  scopes                    = ["/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_analytics_workspace_name}"]
  severity                  = 2
  target_resource_types     = ["Microsoft.OperationalInsights/workspaces"]
  window_duration           = "PT5M"
  action {
    action_groups = ["/subscriptions/${var.subscription_id}/resourcegroups/${var.resource_group_name}/providers/microsoft.insights/actiongroups/${var.action_group_name}"]
  }
  criteria {
    operator                = "LessThan"
    query                   = "Heartbeat\n| where TimeGenerated > ago(5m)\n| order by TimeGenerated\n"
    resource_id_column      = "_ResourceId"
    threshold               = 1
    time_aggregation_method = "Count"
    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }
  depends_on = [ azurerm_monitor_action_group.monitor_action ]
}