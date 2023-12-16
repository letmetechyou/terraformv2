# Configure custom connectivity resources settings
locals {
  configure_connectivity_resources = {
    settings = {
      # Create two hub networks with hub mesh peering enabled
      # and link to DDoS protection plan if created
      hub_networks = [
        {
          enabled = true
          config = {
            address_space                   = ["10.100.0.0/22", ]
            location                        = var.primary_location
            link_to_ddos_protection_plan    = var.enable_ddos_protection
            enable_hub_network_mesh_peering = true
          }
        },
        {
          config = {
            address_space                   = ["10.101.0.0/22", ]
            location                        = var.secondary_location
            link_to_ddos_protection_plan    = var.enable_ddos_protection
            enable_hub_network_mesh_peering = true
          }
        },
      ]
      # Do not create an Virtual WAN resources
      vwan_hub_networks = []
      # Enable DDoS protection plan in the primary location
      ddos_protection_plan = {
        enabled = var.enable_ddos_protection
      }
      # DNS will be deployed with default settings
      dns = {
        enabled = false
      }
    }
    # Set the default location
    location = var.primary_location
    # Create a custom tags input
    advanced = {
        custom_settings_by_resource_type = {
            azurerm_resource_group = {
                connectivity = {
                    (var.primary_location) = {
                        name = "kevin-rg-location1"
                    },
                    (var.secondary_location) = {
                        name = "kevin-rg-location2"
                    }
                }
            }
        }
    }
  }
}
