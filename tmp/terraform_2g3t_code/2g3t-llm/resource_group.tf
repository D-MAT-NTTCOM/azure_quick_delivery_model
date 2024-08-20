# RG の作成
module "resource_group_main" {
  source              = "../modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "resource_group_market" {
  source = "../modules/resource_group"
  resource_group_name = var.resource_group_name_sub
  location = var.location
}
