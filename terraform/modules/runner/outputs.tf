output "public_ip_address" {
  value       = azurerm_linux_virtual_machine.jumphost.public_ip_address
  description = "Public IP address of the jumphost"
}

output "private_ip_address" {
  value       = azurerm_linux_virtual_machine.runner.private_ip_address
  description = "Private IP address of the Runner host"
}

output "key_data" {
  value       = azapi_resource_action.ssh_public_key_gen.output.publicKey
  description = "Public key of the generated SSH key"
}

output "private_key" {
  value       = azapi_resource_action.ssh_public_key_gen.output.privateKey
  sensitive   = true
  description = "(Sensitive) Generated private SSH key"
}