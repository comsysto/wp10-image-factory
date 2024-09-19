module "network" {
  source = "./modules/network"

  prefix                  = local.prefix
  resource_group_location = var.resource_group_location
}

module "runner" {
  source = "./modules/runner"

  prefix                  = local.prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  resource_group_id       = module.network.resource_group.id
  subnet_id               = module.network.azurerm_subnet.id
}


module "acr" {
  source = "./modules/acr"

  prefix                  = local.acr_prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  virtual_network         = module.network.azurerm_virtual_network
  subnet_id               = module.network.azurerm_subnet.id
}

