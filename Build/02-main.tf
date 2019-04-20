provider "azurerm" {
  version = "=1.24.0"
}

resource "azurerm_resource_group" "presentation" {
  name     = "${var.ResourceGroupName}"
  location = "${var.location}"

  tags = {
    environment = "${var.presentation}"
  }
}

resource "azurerm_virtual_network" "presentation" {
  name                = "${var.VNetName}"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.presentation.location}"
  resource_group_name = "${azurerm_resource_group.presentation.name}"
}

resource "azurerm_subnet" "presentation" {
  name                 = "${var.SubNetName}"
  resource_group_name  = "${azurerm_resource_group.presentation.name}"
  virtual_network_name = "${azurerm_virtual_network.presentation.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "presentation" {
  name                = "${var.VMName}-nic"
  location            = "${azurerm_resource_group.presentation.location}"
  resource_group_name = "${azurerm_resource_group.presentation.name}"

  ip_configuration {
    name                          = "${var.VMName}conf"
    subnet_id                     = "${azurerm_subnet.presentation.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.presentation.id}"
  }

  tags {
    environment = "${var.presentation}"
  }
}

resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "${var.VMName}-nsg"
  location            = "${azurerm_resource_group.presentation.location}"
  resource_group_name = "${azurerm_resource_group.presentation.name}"

  security_rule {
    name                       = "SQL"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "1433"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags {
    environment = "${var.presentation}"
  }
}

resource "azurerm_public_ip" "presentation" {
  name                = "${var.VMName}-ip"
  resource_group_name = "${azurerm_resource_group.presentation.name}"
  location            = "${azurerm_resource_group.presentation.location}"
  allocation_method   = "Dynamic"

  tags {
    environment = "${var.presentation}"
  }
}

resource "azurerm_virtual_machine" "presentation" {
  name                  = "${var.VMName}"
  location              = "${azurerm_resource_group.presentation.location}"
  resource_group_name   = "${azurerm_resource_group.presentation.name}"
  network_interface_ids = ["${azurerm_network_interface.presentation.id}"]
  vm_size               = "${var.VMSize}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.VMPublisher}"
    offer     = "${var.VMOffer}"
    sku       = "${var.VMSku}"
    version   = "${var.VMVersion}"
  }
  storage_os_disk {
    name              = "${var.VMName}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.VMName}"
    admin_username = "${var.VMLocalAdmin}"
    admin_password = "${var.VMLocalAdminPassword}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "${var.presentation}"
  }
}
