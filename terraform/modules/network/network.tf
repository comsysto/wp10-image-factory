resource "azurerm_resource_group" "wp10_rg" {
  location = var.resource_group_location
  name     = "${var.prefix}-rg"
}

# Create virtual network
resource "azurerm_virtual_network" "wp10_vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.wp10_rg.location
  resource_group_name = azurerm_resource_group.wp10_rg.name
}

# Create subnet
resource "azurerm_subnet" "wp10_public_subnet" {
  name                 = "${var.prefix}-public-subnet"
  resource_group_name  = azurerm_resource_group.wp10_rg.name
  virtual_network_name = azurerm_virtual_network.wp10_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a private subnet
resource "azurerm_subnet" "wp10_private_subnet" {
  name                            = "${var.prefix}-private-subnet"
  resource_group_name             = azurerm_resource_group.wp10_rg.name
  virtual_network_name            = azurerm_virtual_network.wp10_vnet.name
  address_prefixes                = ["10.0.2.0/24"]
  default_outbound_access_enabled = false
}


# Create the Network Security Group
resource "azurerm_network_security_group" "ssh" {
  name                = "${var.prefix}-ssh-nsg"
  location            = azurerm_resource_group.wp10_rg.location
  resource_group_name = azurerm_resource_group.wp10_rg.name
}

# Create an NSG rule to allow SSH communication
resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "10.0.1.0/24" # Public subnet
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  resource_group_name         = azurerm_resource_group.wp10_rg.name
  network_security_group_name = azurerm_network_security_group.ssh.name
}

# Associate the NSG with the private subnet
resource "azurerm_subnet_network_security_group_association" "private_association" {
  subnet_id                 = azurerm_subnet.wp10_private_subnet.id
  network_security_group_id = azurerm_network_security_group.ssh.id
}