module "state_storage" {
  source = "./modules/state-storage"

  prefix                  = var.prefix
  resource_group_location = var.state_rg_location
  state_env_tag           = var.state_env_tag
  state_project_tag       = var.state_project_tag

}