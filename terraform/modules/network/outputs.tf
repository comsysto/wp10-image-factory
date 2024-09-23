output "resource_group" {
  value       = azurerm_resource_group.wp10_rg
  description = "Resource group output"
}
output "azurerm_virtual_network" {
  value       = azurerm_virtual_network.wp10_vnet
  description = "Virtual network output"
}
output "public_subnet" {
  value       = azurerm_subnet.wp10_public_subnet
  description = "Public subnet output"
}

output "private_subnet" {
  value       = azurerm_subnet.wp10_private_subnet
  description = "Private subnet output"
}
