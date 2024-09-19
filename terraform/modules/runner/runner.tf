# Create network interface
resource "azurerm_network_interface" "runner_nic" {
  name                = "${var.prefix}-runner-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.private_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "runner" {
  name                  = "${var.prefix}-runner-vm"
  admin_username        = var.username
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.runner_nic.id]
  size                  = "Standard_B2ms"
  computer_name         = "runner"

  os_disk {
    name                 = "${var.prefix}-runner-vm-OsDisk"
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

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "boot_diagnostics_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_id" "random_id" {
  keepers = {
    resource_group_name = var.resource_group_name
  }
  byte_length = 8
}



# Create Network Security Group and rules
resource "azurerm_network_security_group" "ssh_nsg" {
  name                = "${var.prefix}-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.jumphost_nic.id
  network_security_group_id = azurerm_network_security_group.ssh_nsg.id
}