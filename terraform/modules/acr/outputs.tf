output "acr_private_ip" {
  value       = azurerm_private_endpoint.acr_private_endpoint.private_service_connection[0].private_ip_address
  description = "Private IP address of the ACR private endpoint."
}