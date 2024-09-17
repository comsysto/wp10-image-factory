module "network" {
  source = "./modules/network"

  prefix                  = var.prefix
  resource_group_location = var.resource_group_location
}

