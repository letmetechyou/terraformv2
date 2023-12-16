# AZURE_VIRTUAL_NETWORK_GATEWAY VALUES EXAMPLE
virtual_network_gateway_data = [
  {
    "gateway1" = {
        # Required

        enabled                 = true
        name                    = "my-vpn-gateway"
        resource_group_name     = "my-resource-group"
        location                = "East US"
        sku                     = "VpnGw1"
        type                    = "RouteBased"
        ip_configuration = [
                {
                public_ip_address_id            = "public-ip-id-1"
                name                            = "ip-config-1"
                private_ip_address_allocation   = "Dynamic"
                subnet_id                       = "subnet-id-1"
                },
                {
                public_ip_address_id            = "public-ip-id-2"
                name                            = "ip-config-2"
                private_ip_address_allocation   = "Static"
                subnet_id                       = "subnet-id-2"
                }
        ]

        # Optional
        active_active                           = false
        default_local_network_gateway_id        = "local-gateway-id"
        edge_zone                               = "edge-zone"
        enable_bgp                              = true
        generation                              = "Generation1"
        private_ip_address_enabled              = true

        tags = {
                environment                     = "Production"
                owner                           = "John Doe"
        }

        bgp_settings    = {
                asn                             = 65515

                peering_addresses = {
                        ip_configuration_name   = "my-ip-config"
                        apipa_addresses         = ["192.168.0.1", "192.168.0.2"]
                }

                peer_weight                     = 1
        }


        custom_route = {
                address_prefixes = ["10.0.0.0/16", "192.168.0.0/24"]
        }

        vpn_type = "RouteBased"
        }
  },
  {
    "gateway2" = {
      # Define the configuration for another virtual network gateway if needed.
    }
  }
]


# AZURE_VIRTUAL_NETWORK MODULE REFERENCE
module "azure_virtual_network_gateway" {
  source = "../../Landing Zone Modules/virtual_network_gateway"

  virtual_network_gateway_data = var.virtual_network_gateway_data[0]
}

# AZURE_VIRTUAL_NETWORK VARIABLE
variable "virtual_network_gateway_data" {
  type = list(map(object({
    # Required
    name               = string
    resource_group_name = string
    location           = string
    sku                = string
    type               = string

    # Optional
    active_active                   = bool
    default_local_network_gateway_id = string
    edge_zone                        = string
    enable_bgp                       = bool
    generation                       = string
    private_ip_address_enabled        = bool
    tags                             = map(string)
    enabled                          = bool

    # BGP Settings (Optional)
    bgp_settings = optional(object({
      asn = number

      peering_addresses = optional(object({
        ip_configuration_name = string
        apipa_addresses       = list(string)
      }))

      peer_weight = number
    }))

    # IP Configuration (Required)
    ip_configuration = list(object({
      # Required
      public_ip_address_id = string

      # Optional
      name                     = string
      private_ip_address_allocation = string
      subnet_id                 = string
    }))

    # Custom Routes (Optional)
    custom_route = optional(object({
      address_prefixes = list(string)
    }))

    # VPN Client Configuration (Optional)
    vpn_client_configuration = optional(object({
      # Define your VPN client configuration attributes here if needed.
    }))

    # VPN Type (Optional)
    vpn_type = string
  })))
}