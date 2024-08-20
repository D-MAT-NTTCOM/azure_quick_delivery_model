module "log" {
  source = "../modules/log"
  resource_group_name = var.resource_group_name
  location = var.location
  resource_group_network_watcher = module.resource_group_main.resource_group_network_watcher
  network_watcher = module.resource_group_main.network_watcher
  log_analytics_workspace_name = var.log_analytics_workspace_name
  nsg_agw_name = var.nsg_agw_name
  nsg_bastion_name = var.nsg_bastion_name
  nsg_web_name = var.nsg_web_name
  nsg_llm_name = var.nsg_llm_name
  subscription_id = var.subscription_id
  strage_account_name = var.storage_account_name
  entra_diagnostic_setting_name = var.entra_diagnostic_setting_name
  activity_diagnostic_setting_name = var.activity_diagnostic_setting_name
  bastion_diagnostic_setting_name = var.bastion_diagnostic_setting_name
  bastion_name = var.bastion_name
  agw_diagnostic_setting_name = var.agw_diagnostic_setting_name
  agw_name = var.agw_name
  dcr_performance_counter_name = var.dcr_performance_counter_name
  dcr_vm_syslog_name = var.dcr_vm_syslog_name
  dcr_vm_syslog_distination_name = var.dcr_vm_syslog_distination_name
  dcr_vm_syslog_source_name = var.dcr_vm_syslog_source_name
  vm_llm_name = var.vm_llm_name
  vm_web_name = var.vm_web_name
  depends_on = [ module.vm, module.storage, module.nsg-agw, module.nsg-bastion, module.nsg-llm, module.nsg-web,module.agw,module.storage]
}
