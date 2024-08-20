module "storage" {
  source = "../modules/storage"
  resource_group_name = var.resource_group_name
  location = var.location
  storage_account_name = var.storage_account_name
  lifecycle_move_days = var.lifecycle_move_days
  lifecycle_delete_days = var.lifecycle_delete_days
  depends_on = [ module.vnet ]
}