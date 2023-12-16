# PRIVATE_DNS_RESOLVER VALUES EXAMPLE
variable "private_dns_resolver_data" {
  default = {
    resolver1 = {
      enabled            = true
      resource_group_name = "example-rg"
      name                = "example-resolver"
      location            = "East US"
      virtual_network_id  = "/subscriptions/subscription-id/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      # Add more fields as needed
    }

    resolver2 = {
      enabled            = false
      resource_group_name = "example-rg"
      name                = "disabled-resolver"
      location            = "West US"
      
      virtual_network_id  = "/subscriptions/subscription-id/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      virtual_network_name = "example-vnet"
      virtual_network_key = "vnet1"
      # Add more fields as needed
    }
  }
}

# PRIVATE_DNS_RESOLVER MODULE REFERENCE
module "private_dns_resolver" {
        source = "./Modules/private_dns_resolver"

        private_dns_resolver_data = var.private_dns_resolver_data
}

# PRIVATE_DNS_RESOLVER VARIABLE
variable "private_dns_resolver_data" {
  description = "Map of private DNS resolver configurations."

  type = map(object({
    
    # Required
    enabled            = bool
    resource_group_name = string
    name                = string
    location            = string

    # Required, but set as optional for interpolation of different values (id, name, key)
    virtual_network_id  = optional(string)
    virtual_network_name = optional(string)
    virtual_network_key = optional(string)
  }))
  default = {}
}