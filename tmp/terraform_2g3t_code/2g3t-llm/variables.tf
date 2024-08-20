variable "resource_group_name" {}

variable "resource_group_name_sub" {}

variable "subscription_id" {}

variable "location" {
  type    = string
  default = "japaneast"
}

# vnet
variable "virtual_network_name" {}

variable "address_space" {}

variable "subnets" {}

variable "snet_agw_name" {}
variable "snet_web_name" {}
variable "snet_llm_name" {}


variable "pip_bastion_name" {}
variable "pip_agw_name" {}

##nsg
###bastion
variable "nsg_bastion_ip_addr_maint" {}
variable "nsg_bastion_ip_addr_dev_01" {}
variable "nsg_bastion_ip_addr_dev_02" {}
variable "nsg_bastion_name" {}

###agw
variable "nsg_agw_name" {}
variable "nsg_agw_ip_addr_customer" {}

###web
variable "nsg_web_name" {}

###llm
variable "nsg_llm_name" {}

#vm
variable "nic_llm_name" {}
variable "nic_web_name" {}
variable "admin_username" {}
variable "vm_llm_name" {}
variable "vm_web_name" {}

variable "disk_llm_size" {}
variable "disk_web_size" {}

variable "public_key_llm" {}
variable "public_key_web" {}

variable "private_ip_llm" {}
variable "private_ip_web" {}

#bastion
variable "bastion_name" {}

#agw
variable "agw_name" {}
variable "waf_name" {}
variable "allow_ip_waf" {}
variable "backend_pool_name" {}
variable "affinity_name_443" {}
variable "affinity_name_80" {}
variable "backend_name_443" {}
variable "backend_name_80" {}
variable "backend_lister_name_443" {}
variable "backend_lister_name_80" {}
variable "ssl_certificate_name" {}
variable "ssl_certificate_data" {}
variable "ssl_certificate_password" {}
variable "backend_route_name_443" {}
variable "backend_route_name_80" {}

#storage
variable "storage_account_name" {}
variable "lifecycle_move_days" {}
variable "lifecycle_delete_days" {}

#log
variable "log_analytics_workspace_name" {}
variable "entra_diagnostic_setting_name" {}
variable "activity_diagnostic_setting_name" {}
variable "bastion_diagnostic_setting_name" {}
variable "agw_diagnostic_setting_name" {}
variable "dcr_performance_counter_name" {}
variable "dcr_vm_syslog_name" {}
variable "dcr_vm_syslog_distination_name" {}
variable "dcr_vm_syslog_source_name" {}


#monitor
variable "action_group_name" {}
variable "action_group_display_name" {}
variable "action_group_email" {}
variable "action_group_email_name" {}

#backup
variable "backup_container_name" {}
variable "backup_policy_name" {}