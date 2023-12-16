resource "azurerm_resource_group" "hub" {
  name     = "hub-prd-centralus"
  location = "centralus"
}

resource "azurerm_resource_group" "lz1" {
  name     = "landing-zone-1"
  location = "centralus"
}

resource "azurerm_resource_group" "lz2" {
  name     = "landing-zone-2"
  location = "centralus"
}