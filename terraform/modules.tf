module "network" {
  source = "./modules/network"

  prefix                  = local.prefix
  resource_group_location = var.resource_group_location
  env_tag                 = var.env_tag
  project_tag             = var.project_tag
}

module "runner" {
  source = "./modules/runner"

  prefix                  = local.prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  resource_group_id       = module.network.resource_group.id
  public_subnet_id        = module.network.public_subnet.id
  private_subnet_id       = module.network.private_subnet.id
  runner_image_id         = var.runner_image_id
  env_tag                 = var.env_tag
  project_tag             = var.project_tag
}


module "acr" {
  source = "./modules/acr"

  prefix                  = local.acr_prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  virtual_network         = module.network.azurerm_virtual_network
  subnet_id               = module.network.private_subnet.id
  env_tag                 = var.env_tag
  project_tag             = var.project_tag
}

module "acg" {
  source = "./modules/acg"

  prefix                  = local.acr_prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  subnet_id               = module.network.private_subnet.id
  virtual_network         = module.network.azurerm_virtual_network
  env_tag                 = var.env_tag
  project_tag             = var.project_tag
}

module "firewall" {
  source = "./modules/firewall"

  prefix                  = local.prefix
  resource_group_location = var.resource_group_location
  resource_group_name     = module.network.resource_group.name
  public_subnet_id        = module.network.public_subnet.id
  private_subnet_id       = module.network.private_subnet.id
  virtual_network         = module.network.azurerm_virtual_network.name
  env_tag                 = var.env_tag
  project_tag             = var.project_tag
}

module "github_output" {
  source = "./modules/github_output"

  repository     = var.repository
  ssh_key        = module.runner.private_key
  jumphost_ip    = module.runner.public_ip_address
  runner_host_ip = module.runner.private_ip_address
}