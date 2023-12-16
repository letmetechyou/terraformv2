resource "azurerm_virtual_network_peering" "hub-to-lz1" {
  name                      = "hub-to-lz1"
  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.lz1.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "lz1-to-hub" {
  name                      = "lz1-to-hub"
  resource_group_name       = azurerm_resource_group.lz1.name
  virtual_network_name      = azurerm_virtual_network.lz1.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_forwarded_traffic   = true
}


resource "azurerm_virtual_network_peering" "hub-to-lz2" {
  name                      = "hub-to-lz2"
  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.lz2.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "lz2-to-hub" {
  name                      = "lz2-to-hub"
  resource_group_name       = azurerm_resource_group.lz2.name
  virtual_network_name      = azurerm_virtual_network.lz2.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_forwarded_traffic   = true
}