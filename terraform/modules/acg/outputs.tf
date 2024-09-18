# Export Outputs
output "gallery_id" {
  value = azurerm_shared_image_gallery.factory_image_gallery.id
}

output "gallery_private_endpoint_ip" {
  value = azurerm_private_endpoint.gallery_pe.private_service_connection[0].private_ip_address
}
