# Create public IPs - development purposes only
resource "azurerm_public_ip" "development_public_ip" {
  name                = "${var.prefix}-public-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "jumphost_nic" {
  name                = "${var.prefix}-jumphost-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.public_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.development_public_ip.id
  }
}

# Jumphost
resource "azurerm_linux_virtual_machine" "jumphost" {
  name                  = "${var.prefix}-jumphost-vm"
  admin_username        = var.username
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.jumphost_nic.id]
  size                  = "Standard_B2ms"
  computer_name         = "jumphost"

  os_disk {
    name                 = "${var.prefix}-jumphost-vm-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.boot_diagnostics_storage_account.primary_blob_endpoint
  }
}