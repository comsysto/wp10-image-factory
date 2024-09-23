output "resource_group_name" {
  value       = azurerm_resource_group.state_rg.name
  description = "Name of the created resource group. Value needed for config.azurerm.tfbackend."
}

output "state_storage_account_name" {
  value       = azurerm_storage_account.tfstate.name
  description = "Name of the storage account used for terraform state backend. Value needed for config.azurerm.tfbackend."
}

output "state_container_name" {
  value       = azurerm_storage_container.tfstate.name
  description = "Name of the storage account container used for the terraform state. Value needed for config.azurerm.tfbackend."
}
