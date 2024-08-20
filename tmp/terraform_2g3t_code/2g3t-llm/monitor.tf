module "monitor" {
  source = "../modules/monitor"
  resource_group_name = var.resource_group_name
  location = var.location
  action_group_name = var.action_group_name
  action_group_display_name = var.action_group_display_name
  action_group_email = var.action_group_email
  action_group_email_name = var.action_group_email_name
  subscription_id = var.subscription_id
  vm_llm_name = var.vm_llm_name
  vm_web_name = var.vm_web_name
  log_analytics_workspace_name = var.log_analytics_workspace_name
  depends_on = [ module.vm , module.log]
}