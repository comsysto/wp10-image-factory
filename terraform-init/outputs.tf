output "resource_group_name" {
  value       = module.state_storage.resource_group_name
  description = "Name of the created resource group. Value needed for `config.azurerm.tfbackend`"
}

output "state_storage_account_name" {
  value       = module.state_storage.state_storage_account_name
  description = "Name of the storage account used for terraform state backend. Value needed for `config.azurerm.tfbackend`"
}

output "state_container_name" {
  value       = module.state_storage.state_container_name
  description = "Name of the storage account container used for the terraform state. Value needed for `config.azurerm.tfbackend`"
}