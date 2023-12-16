####### hub network #######


resource "azurerm_virtual_network" "hub" {
  name                = "hub-vnet"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["192.168.5.0/24"]
  tags = {
    environment = "Production"
  }

}

resource "azurerm_subnet" "hubvm-subnet" {
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  name                 = "vm-subnet"
  address_prefixes     = ["192.168.5.0/28"]
}

resource "azurerm_subnet" "hub-azurefirewallsubnet" {
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  name                 = "AzureFirewallSubnet"
  address_prefixes     = ["192.168.5.64/26"]
}

####### hub network #######

####### lz1 network #######

resource "azurerm_virtual_network" "lz1" {
  name                = "lz1-vnet"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name
  address_space       = ["192.168.1.0/24"]
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "lz1vm-subnet" {
  resource_group_name  = azurerm_resource_group.lz1.name
  virtual_network_name = azurerm_virtual_network.lz1.name
  name                 = "vm-subnet"
  address_prefixes     = ["192.168.1.0/28"]
}

resource "azurerm_subnet" "lz1-azurefirewallsubnet" {
  resource_group_name  = azurerm_resource_group.lz1.name
  virtual_network_name = azurerm_virtual_network.lz1.name
  name                 = "AzureFirewallSubnet"
  address_prefixes     = ["192.168.1.64/26"]
}

resource "azurerm_subnet" "lz1-azurefirewallmanagementsubnet" {
  resource_group_name  = azurerm_resource_group.lz1.name
  virtual_network_name = azurerm_virtual_network.lz1.name
  name                 = "AzureFirewallManagementSubnet"
  address_prefixes     = ["192.168.1.128/26"]
}

resource "azurerm_virtual_network" "lz1-nonroutable" {
  name                = "lz1-nonroutable-vnet"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name
  address_space       = ["192.168.2.0/24"]
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "lz1nonroutablevm-subnet" {
  resource_group_name  = azurerm_resource_group.lz1.name
  virtual_network_name = azurerm_virtual_network.lz1-nonroutable.name
  name                 = "vm-subnet"
  address_prefixes     = ["192.168.2.0/28"]
}

####### lz1 network #######

####### lz2 network #######

resource "azurerm_virtual_network" "lz2" {
  name                = "lz2-vnet"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name
  address_space       = ["192.168.3.0/24"]
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "lz2vm-subnet" {
  resource_group_name  = azurerm_resource_group.lz2.name
  virtual_network_name = azurerm_virtual_network.lz2.name
  name                 = "vm-subnet"
  address_prefixes     = ["192.168.3.0/28"]
}

resource "azurerm_subnet" "lz2-azurefirewallsubnet" {
  resource_group_name  = azurerm_resource_group.lz2.name
  virtual_network_name = azurerm_virtual_network.lz2.name
  name                 = "AzureFirewallSubnet"
  address_prefixes     = ["192.168.3.64/26"]
}

resource "azurerm_subnet" "lz2-azurefirewallmanagementsubnet" {
  resource_group_name  = azurerm_resource_group.lz2.name
  virtual_network_name = azurerm_virtual_network.lz2.name
  name                 = "AzureFirewallManagementSubnet"
  address_prefixes     = ["192.168.3.128/26"]
}


resource "azurerm_virtual_network" "lz2-nonroutable" {
  name                = "lz2-nonrouteable-vnet"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name
  address_space       = ["192.168.4.0/24"]
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "lz2nonroutablevm-subnet" {
  resource_group_name  = azurerm_resource_group.lz2.name
  virtual_network_name = azurerm_virtual_network.lz2-nonroutable.name
  name                 = "vm-subnet"
  address_prefixes     = ["192.168.4.0/28"]
}

####### lz2 network #######
