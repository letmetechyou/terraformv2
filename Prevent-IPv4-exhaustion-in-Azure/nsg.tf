resource "azurerm_network_security_group" "main" {
  name                = "default"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  security_rule {
    name                       = "rdp-access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "hub" {
  subnet_id                 = azurerm_subnet.hubvm-subnet.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet_network_security_group_association" "lz1" {
  subnet_id                 = azurerm_subnet.lz1vm-subnet.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet_network_security_group_association" "lz1nonroutable" {
  subnet_id                 = azurerm_subnet.lz1nonroutablevm-subnet.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet_network_security_group_association" "lz2" {
  subnet_id                 = azurerm_subnet.lz2vm-subnet.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet_network_security_group_association" "lz2nonroutable" {
  subnet_id                 = azurerm_subnet.lz2nonroutablevm-subnet.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet_network_security_group_association" "bastion1" {
  subnet_id                 = azurerm_subnet.lz1bastion-subnet.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet_network_security_group_association" "bastion2" {
  subnet_id                 = azurerm_subnet.lz2bastion-subnet.id
  network_security_group_id = azurerm_network_security_group.main.id
}