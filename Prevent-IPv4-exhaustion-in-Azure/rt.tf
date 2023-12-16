resource "azurerm_route_table" "lz1rt1" {
  name                = "rt-1"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name

  route {
    name                   = "route-to-hub"
    address_prefix         = "0.0.0.0/0"
    next_hop_in_ip_address = azurerm_firewall.lz1.ip_configuration[0].private_ip_address
    next_hop_type          = "VirtualAppliance"
  }
}

resource "azurerm_subnet_route_table_association" "lz1rt1" {
  subnet_id      = azurerm_subnet.lz1vm-subnet.id
  route_table_id = azurerm_route_table.lz1rt1.id
}

resource "azurerm_route_table" "lz1rt2" {
  name                = "rt-2"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name

  route {
    name                   = "route-to-azfw"
    address_prefix         = "0.0.0.0/0"
    next_hop_in_ip_address = azurerm_firewall.main.ip_configuration[0].private_ip_address
    next_hop_type          = "VirtualAppliance"
  }
}

resource "azurerm_subnet_route_table_association" "lz1rt2" {
  subnet_id      = azurerm_subnet.lz2-azurefirewallsubnet.id
  route_table_id = azurerm_route_table.lz1rt2.id
}


resource "azurerm_route_table" "lz2rt1" {
  name                = "rt-3"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name

  route {
    name                   = "route-to-hub"
    address_prefix         = "0.0.0.0/0"
    next_hop_in_ip_address = azurerm_firewall.lz2.ip_configuration[0].private_ip_address
    next_hop_type          = "VirtualAppliance"
  }
}

resource "azurerm_route_table" "lz2rt2" {
  name                = "rt-4"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name

  route {
    name                   = "route-to-azfw"
    address_prefix         = "0.0.0.0/0"
    next_hop_in_ip_address = azurerm_firewall.main.ip_configuration[0].private_ip_address
    next_hop_type          = "VirtualAppliance"
  }
}

resource "azurerm_subnet_route_table_association" "lz2rt1" {
  subnet_id      = azurerm_subnet.lz2vm-subnet.id
  route_table_id = azurerm_route_table.lz2rt1.id
}

resource "azurerm_subnet_route_table_association" "lz2rt2" {
  subnet_id      = azurerm_subnet.lz2-azurefirewallsubnet.id
  route_table_id = azurerm_route_table.lz2rt2.id
}