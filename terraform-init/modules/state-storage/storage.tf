resource "azurerm_resource_group" "state_rg" {
  location = var.resource_group_location
  name     = "${var.prefix}-state-rg"

  tags = {
    environment = var.state_env_tag
    project = var.state_project_tag
  }
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.state_rg.name
  location                 = azurerm_resource_group.state_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = var.state_env_tag
    project = var.state_project_tag
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}
