output "resource_group_name" {
  value = azurerm_resource_group.state_rg.name
}

output "state_storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "state_container_name" {
  value = azurerm_storage_container.tfstate.name
}
