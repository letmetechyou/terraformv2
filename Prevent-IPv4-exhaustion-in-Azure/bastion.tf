resource "azurerm_subnet" "lz1bastion-subnet" {
  resource_group_name  = azurerm_resource_group.lz1.name
  virtual_network_name = azurerm_virtual_network.lz1-nonroutable.name
  name                 = "bastion-subnet"
  address_prefixes     = ["192.168.2.16/28"]
}

resource "azurerm_network_interface" "bastionnicvm1" {
  name                = "bastionnicvm1"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lz1bastion-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastionpipvm1.id
  }
}

resource "azurerm_public_ip" "bastionpipvm1" {
  name                = "bastionvm2pip"
  resource_group_name = azurerm_resource_group.lz1.name
  location            = azurerm_resource_group.lz1.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_windows_virtual_machine" "bastionvm1" {
  name                = "bastion1"
  resource_group_name = azurerm_resource_group.lz1.name
  location            = azurerm_resource_group.lz1.location
  size                = "Standard_B2ms"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.bastionnicvm1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  lifecycle {
    ignore_changes = [ admin_password ]
  }
}

resource "azurerm_subnet" "lz2bastion-subnet" {
  resource_group_name  = azurerm_resource_group.lz2.name
  virtual_network_name = azurerm_virtual_network.lz2-nonroutable.name
  name                 = "bastion-subnet"
  address_prefixes     = ["192.168.4.16/28"]
}

resource "azurerm_network_interface" "bastionnicvm2" {
  name                = "bastionnicvm2"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lz2bastion-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastionpipvm2.id
  }
}

resource "azurerm_public_ip" "bastionpipvm2" {
  name                = "bastionvm2pip"
  resource_group_name = azurerm_resource_group.lz2.name
  location            = azurerm_resource_group.lz2.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_windows_virtual_machine" "bastionvm2" {
  name                = "bastion2"
  resource_group_name = azurerm_resource_group.lz2.name
  location            = azurerm_resource_group.lz2.location
  size                = "Standard_B2ms"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.bastionnicvm2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  lifecycle {
    ignore_changes = [ admin_password ]
  }
}