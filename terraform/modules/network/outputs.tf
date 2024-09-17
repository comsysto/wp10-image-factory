output "resource_group_name" {
  value = azurerm_resource_group.wp10_rg.name
}
output "azurerm_virtual_network" {
  value = azurerm_virtual_network.wp10_vnet.name
}
output "azurerm_subnet" {
  value = azurerm_subnet.wp10_subnet.name
}
