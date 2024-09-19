output "public_ip_address" {
  value = azurerm_linux_virtual_machine.jumphost.public_ip_address
}

output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
}

