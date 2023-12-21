resource "azurerm_firewall_policy" "hub" {
  name                = "hubfw-policy"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
}

resource "azurerm_firewall_policy_rule_collection_group" "main" {
  name               = "fwpolicy-rcg"
  firewall_policy_id = azurerm_firewall_policy.hub.id
  priority           = 500
  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 500
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall_policy" "lz1" {
  name                = "lz1fw-policy"
  resource_group_name = azurerm_resource_group.lz1.name
  location            = azurerm_resource_group.lz1.location
}

resource "azurerm_firewall_policy_rule_collection_group" "lz1" {
  name               = "fwpolicy-rcg"
  firewall_policy_id = azurerm_firewall_policy.lz1.id
  priority           = 500
  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 500
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall_policy" "lz2" {
  name                = "lz2fw-policy"
  resource_group_name = azurerm_resource_group.lz2.name
  location            = azurerm_resource_group.lz2.location
}

resource "azurerm_firewall_policy_rule_collection_group" "lz2" {
  name               = "fwpolicy-rcg"
  firewall_policy_id = azurerm_firewall_policy.lz2.id
  priority           = 500
  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 500
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}