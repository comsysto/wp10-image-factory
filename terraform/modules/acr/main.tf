resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Premium"
  admin_enabled       = true

  tags = {
    environment = var.env_tag
    project     = var.project_tag
  }
}

# Private DNS Zone for ACR
resource "azurerm_private_dns_zone" "acr_private_dns" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.env_tag
    project     = var.project_tag
  }
}
# TODO
#name = "{regionName}.data.privatelink.azurecr.io"  

# Link DNS Zone to VNet for ACR
resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
  name                  = "${var.prefix}-dns-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_private_dns.name
  virtual_network_id    = var.virtual_network.id

  tags = {
    environment = var.env_tag
    project     = var.project_tag
  }
}

# Private Endpoints for ACR
resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "${var.prefix}-acr-endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.prefix}-acr-connection"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  tags = {
    environment = var.env_tag
    project     = var.project_tag
  }
}

# Private DNS A Record for ACR
resource "azurerm_private_dns_a_record" "acr_a_record" {
  name                = "${var.prefix}acr"
  zone_name           = azurerm_private_dns_zone.acr_private_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.acr_private_endpoint.private_service_connection[0].private_ip_address]

  tags = {
    environment = var.env_tag
    project     = var.project_tag
  }
}



