resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "vm1"
  resource_group_name = azurerm_resource_group.lz1.name
  location            = azurerm_resource_group.lz1.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nicvm1.id,
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
}

resource "azurerm_network_interface" "nicvm1" {
  name                = "nicvm1"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lz1vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm2" {
  name                = "vm2"
  resource_group_name = azurerm_resource_group.lz1.name
  location            = azurerm_resource_group.lz1.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nicvm2.id,
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
}

resource "azurerm_network_interface" "nicvm2" {
  name                = "nicvm2"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lz2vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm3" {
  name                = "vm3"
  resource_group_name = azurerm_resource_group.lz2.name
  location            = azurerm_resource_group.lz2.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nicvm3.id,
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
}

resource "azurerm_network_interface" "nicvm3" {
  name                = "nicvm3"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lz1nonroutablevm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm4" {
  name                = "vm4"
  resource_group_name = azurerm_resource_group.lz2.name
  location            = azurerm_resource_group.lz2.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nicvm4.id,
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
}

resource "azurerm_network_interface" "nicvm4" {
  name                = "nicvm4"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lz2nonroutablevm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "vm5" {
  name                = "vm5"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nicvm5.id,
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
}

resource "azurerm_network_interface" "nicvm5" {
  name                = "nicvm5"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hubvm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}