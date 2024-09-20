resource "azurerm_subnet" "azfw_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "pip_azfw" {
  name                = "${var.prefix}-pip-azfw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw" {
  name                = "${var.prefix}-azfw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku_tier
  ip_configuration {
    name                 = "${var.prefix}-azfw-ipconfig"
    subnet_id            = azurerm_subnet.azfw_subnet.id
    public_ip_address_id = azurerm_public_ip.pip_azfw.id
  }
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
}

resource "azurerm_firewall_policy" "azfw_policy" {
  name                     = "${var.prefix}-azfw-policy"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  sku                      = var.firewall_sku_tier
  threat_intelligence_mode = "Alert"
}


resource "azurerm_firewall_policy_rule_collection_group" "prcg" {
  name               = "${var.prefix}-prcg"
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
  priority           = 300
  application_rule_collection {
    name     = "${var.prefix}-appRc1"
    priority = 101
    action   = "Allow"
    rule {
      name = "${var.prefix}-appRule1"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      destination_fqdns = ["www.microsoft.com", "*.github.com", "www.comsystoreply.de", "*.docker.com"]
      source_addresses  = ["10.0.1.0/24", "10.0.2.0/24"]
    }

  }
}

resource "azurerm_route_table" "rt" {
  name                = "${var.prefix}-rt-azfw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  route {
    name                   = "${var.prefix}-azfwDefaultRoute"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "runner_subnet_rt_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = azurerm_route_table.rt.id
}
