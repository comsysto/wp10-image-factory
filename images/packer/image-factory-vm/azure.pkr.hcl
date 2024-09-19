source "azure-arm" "vm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  location        = var.location

  managed_image_name                = "${var.gallery_image_name}-${formatdate("DD-MMM-YYYY-hh-mm-ss", timestamp())}"
  managed_image_resource_group_name = var.resource_group

  communicator    = "ssh"
  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts-gen2"

  vm_size = "Standard_B2ms"

  public_ip_sku = "Standard"

  shared_image_gallery_destination {
    subscription   = var.subscription_id
    resource_group = var.resource_group
    gallery_name   = var.gallery_name
    image_name     = var.gallery_image_name
    image_version  = var.gallery_image_version
    target_region {
      name = var.location
    }
  }
}
