module "network" {
  source = "./modules/network"

  prefix                  = var.prefix
  resource_group_location = var.resource_group_location
}

module "runner" {
  source = "./modules/runner"

  prefix                  = var.prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  resource_group_id       = module.network.resource_group.id
  subnet_id               = module.network.azurerm_subnet.id
}

module "acg" {
  source = "./modules/acg"

  prefix                  = var.prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  subnet_id               = module.network.azurerm_subnet.id
  virtual_network         = module.network.azurerm_virtual_network
}