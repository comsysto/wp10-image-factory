resource "azurerm_resource_group" "wp10_rg" {
  location = var.resource_group_location
  name     = "${prefix.id}-rg"
}

# Create virtual network
resource "azurerm_virtual_network" "wp10_vnet" {
  name                = "${prefix.id}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.wp10_rg.location
  resource_group_name = azurerm_resource_group.wp10_rg.name
}

# Create subnet
resource "azurerm_subnet" "wp10_subnet" {
  name                 = "${prefix.id}-subnet"
  resource_group_name  = azurerm_resource_group.wp10_rg.name
  virtual_network_name = azurerm_virtual_network.wp10_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
