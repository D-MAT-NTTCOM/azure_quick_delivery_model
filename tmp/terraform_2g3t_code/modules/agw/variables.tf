variable "resource_group_name" {}

variable "location" {}

variable "agw_name" {}

variable "waf_name" {}

variable "allow_ip_waf" {}

variable "waf_id" {}

variable "pip_id_waf" {}

variable "subnet_id_agw" {}

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

variable "backend_address_pool_id" {}

variable "nic_web_id" {}