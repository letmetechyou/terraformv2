####### hub azure firewall #######

resource "azurerm_firewall" "main" {
  name                = "hub-firewall"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.hub.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub-azurefirewallsubnet.id
    public_ip_address_id = azurerm_public_ip.hubfwpip.id
  }
}

resource "azurerm_public_ip" "hubfwpip" {
  name                = "hubfwpip"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

####### hub azure firewall #######

####### lz1 azure firewall #######

resource "azurerm_firewall" "lz1" {
  name                = "lz1-firewall"
  location            = azurerm_resource_group.lz1.location
  resource_group_name = azurerm_resource_group.lz1.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.lz1.id
  private_ip_ranges                 = ["255.255.255.255/32"]
  management_ip_configuration {
    name = "lz1mgmtpip"
    subnet_id = azurerm_subnet.lz1-azurefirewallmanagementsubnet.id
    public_ip_address_id = azurerm_public_ip.lz1fwpip.id
  }

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.lz1-azurefirewallsubnet.id
  }
}


resource "azurerm_public_ip" "lz1fwpip" {
  name                = "lz1fwpip"
  resource_group_name = azurerm_resource_group.lz1.name
  location            = azurerm_resource_group.lz1.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

####### lz1 azure firewall #######

####### lz2 azure firewall #######

resource "azurerm_firewall" "lz2" {
  name                = "lz2-firewall"
  location            = azurerm_resource_group.lz2.location
  resource_group_name = azurerm_resource_group.lz2.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.lz2.id
  private_ip_ranges                 = ["255.255.255.255/32"]
  management_ip_configuration {
    name = "lz2mgmtpip"
    subnet_id = azurerm_subnet.lz2-azurefirewallmanagementsubnet.id
    public_ip_address_id = azurerm_public_ip.lz2fwpip.id
  }

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.lz2-azurefirewallsubnet.id
  }
}

resource "azurerm_public_ip" "lz2fwpip" {
  name                = "lz2fwpip"
  resource_group_name = azurerm_resource_group.lz2.name
  location            = azurerm_resource_group.lz2.location
  sku                 = "Standard"
  allocation_method   = "Static"
}

####### lz2 azure firewall #######
