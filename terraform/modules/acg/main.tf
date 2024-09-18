

# Azure Compute Gallery and its Private Endpoint
resource "azurerm_shared_image_gallery" "factory_image_gallery" {
  name                = "cariadImageFactoryGallery"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  description         = "Gallery for storing golden images"
}

resource "azurerm_private_endpoint" "gallery_pe" {
  name                = "galleryPrivateEndpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "galleryPrivateConnection"
    private_connection_resource_id = azurerm_shared_image_gallery.factory_image_gallery.id
    is_manual_connection           = false
    subresource_names              = ["gallery"]
  }
}

resource "azurerm_private_dns_zone" "gallery_privatednszone" {
  name                = "privatelink.gallery.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "gallery_dns_link" {
  name                  = "galleryDNSLink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.gallery_privatednszone.name
  virtual_network_id    = var.virtual_network.id
}

resource "azurerm_private_dns_a_record" "gallery_dns_a_record" {
  name                = "private_endpoint_record"
  zone_name           = azurerm_private_dns_zone.gallery_privatednszone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.gallery_pe.private_service_connection[0].private_ip_address]
}

