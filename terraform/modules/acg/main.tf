

# Azure Compute Gallery and its Private Endpoint
resource "azurerm_shared_image_gallery" "factory_image_gallery" {
  name                = "cariadImageFactoryGallery"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  description         = "Gallery for storing golden images"
}
