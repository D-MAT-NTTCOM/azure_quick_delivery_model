module "backup" {
  source = "../modules/backup"
  resource_group_name = var.resource_group_name
  location = var.location
  backup_container_name = var.backup_container_name
  backup_policy_name = var.backup_policy_name
  depends_on = [ module.storage ]
}