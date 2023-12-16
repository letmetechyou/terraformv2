# AZURE_FIREWALL VALUES EXAMPLE
firewall_data = [
  {
    "firewall1" = {
      enabled                        = true
      name                           = "my-firewall"
      location                       = "East US"
      resource_group_name            = "my-resource-group"
      sku_name                       = "AZFW_VNet"
      threat_intel_mode              = "Alert"
      zones                          = ["1", "2"]
      
      ip_configurations = [
        {
          name                         = "config1"
          subnet_id                    = "/subscriptions/subscription-id/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1"
          public_ip_address_id         = null
          private_ip_address           = "10.0.1.4"
          private_ip_address_allocation = "Dynamic"
        }
      ]

      tags = {
        environment = "Production"
      }
    }
  },
]

# AZURE_FIREWALL MODULE REFERENCE
module "azure_firewall" {
  source = "../../Landing Zone Modules/azure_firewall"

  firewall_data = var.firewall_data[0]
}

# AZURE_FIREWALL VARIABLE
variable "firewall_data" {
  type = list(map(object({
    # Required
    enabled                        = bool
    name                           = string
    location                       = string
    resource_group_name            = string
    sku_name                       = string
    threat_intel_mode              = string
    zones                          = list(string)

    # Optional
    ip_configurations              = optional(list(object({
      name                         = string
      subnet_id                    = string
      public_ip_address_id         = string
      private_ip_address           = string
      private_ip_address_allocation = string
    })))
    tags                           = optional(map(string))
  })))
}
