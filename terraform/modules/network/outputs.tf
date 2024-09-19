output "resource_group" {
  value = azurerm_resource_group.wp10_rg
}
output "azurerm_virtual_network" {
  value = azurerm_virtual_network.wp10_vnet
}
output "public_subnet" {
  value = azurerm_subnet.wp10_public_subnet
}

output "private_subnet" {
  value = azurerm_subnet.wp10_private_subnet
}
