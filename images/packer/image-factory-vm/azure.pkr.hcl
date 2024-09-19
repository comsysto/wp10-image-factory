source "azure-arm" "vm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  location        = var.location

  managed_image_name                = "test-ubuntu-22.04-${formatdate("DD-MMM-YYYY-hh-mm-ss", timestamp())}"
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
    image_name     = "test-ubuntu-22.04"
    image_version  = "1.0.0"
    target_region {
      name = var.location
    }
  }
}

# az sig image-definition create --resource-group "wp10-silvija-rg" --gallery-name "wp10silvijaACG" --gallery-image-definition "test-ubuntu-22.04" --publisher "Canonical" --offer "0001-com-ubuntu-server-jammy" --sku "22_04-lts-gen2" --os-type linux