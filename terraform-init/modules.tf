module "state_storage" {
  source = "./modules/state-storage"
  
  prefix = var.prefix
  resource_group_location = var.state_rg_location
}