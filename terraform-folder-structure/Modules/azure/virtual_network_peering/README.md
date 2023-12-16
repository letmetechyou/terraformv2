# AZURERM_VIRTUAL_NETWORK_PEERING VALUES EXAMPLE
variable "virtual_network_peering_data" {
    vnet1_to_vnet2 = {
      enabled                       = true
      resource_group_name           = "my-resource-group"
      remote_virtual_network_id     = "/subscriptions/subscription-id/resourceGroups/remote-rg/providers/Microsoft.Network/virtualNetworks/remote-vnet"
      name                          = "vnet1-to-vnet2"
      virtual_network_name          = "my-vnet"
      allow_gateway_transit         = false
      allow_virtual_network_access  = true
      allow_forwarded_traffic       = true
      triggers                      = { "key" = "value" }
      use_remote_gateways           = true
    }
    vnet2_to_vnet1 = {
      enabled                       = true
      resource_group_name           = "my-resource-group"
      remote_virtual_network_id     = "/subscriptions/subscription-id/resourceGroups/remote-rg/providers/Microsoft.Network/virtualNetworks/remote-vnet"
      name                          = "vnet2-to-vnet1"
      virtual_network_name          = "my-vnet"
      allow_gateway_transit         = true
      allow_virtual_network_access  = false
      allow_forwarded_traffic       = false
      triggers                      = { "another_key" = "another_value" }
      use_remote_gateways           = false
    }
}

# AZURE_VIRTUAL_NETWORK_PEERING MODULE REFERENCE
module "virtual_network_peering" {
  source = "./Modules/virtual_network_peering"

  virtual_network_peering_data = var.virtual_network_peering_data
}

# AZURE_VIRTUAL_NETWORK_PEERING VARIABLE REFERENCE
variable "virtual_network_peering_data" {
  type = map(object({
    # Required
    enabled                    = bool
    resource_group_name        = string
    remote_virtual_network_id  = string
    name                       = string
    virtual_network_name       = string

    # Optional
    allow_gateway_transit       = optional(bool)
    allow_virtual_network_access = optional(bool)
    allow_forwarded_traffic      = optional(bool)
    triggers                     = optional(map(any))
    use_remote_gateways          = optional(bool)
  }))
}
