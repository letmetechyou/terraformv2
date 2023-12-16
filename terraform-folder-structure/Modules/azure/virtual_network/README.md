# AZURE_VIRTUAL_NETWORK VALUES EXAMPLE
variable "virtual_network_data" {
  type = list(map(object({
    # Required
    enabled             = true
    name                = "my-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "East US"
    resource_group_name = "my-rg"

    # Optional
    bgp_community          = "65000:123"
    dns_servers            = ["8.8.8.8", "8.8.4.4"]
    edge_zone              = "edgezone-1"
    flow_timeout_in_minutes = 30

    ddos_protection_plan = [
      {
        id     = "/subscriptions/abcd1234/resourceGroups/my-rg/providers/Microsoft.Network/ddosProtectionPlans/ddos-plan-1"
        enable = "true"
      },
      {
        id     = "/subscriptions/abcd1234/resourceGroups/my-rg/providers/Microsoft.Network/ddosProtectionPlans/ddos-plan-2"
        enable = "false"
      }
    ]

    encryption = [
      {
        enforcement = "Enabled"
      },
      {
        enforcement = "Disabled"
      }
    ]

    subnets = [
      {
        enabled        = true
        name           = "subnet1"
        address_prefix = "10.0.1.0/24"
        security_group = "sg-1"
      },
      {
        enabled        = false
        name           = "subnet2"
        address_prefix = "10.0.2.0/24"
        security_group = "sg-2"
      }
    ]

    tags = {
      environment = "dev"
      owner       = "John Doe"
    }
  })))
}

# AZURE_VIRTUAL_NETWORK MODULE REFERENCE
module "azure_virtual_network" {
  source = "../../Landing Zone Modules/azure_virtual_network"

  virtual_network_data = var.virtual_network_data[0]
}

# AZURE_VIRTUAL_NETWORK VARIABLE
variable "virtual_network_data" {
	type = list(map(object({
		# Required
		enabled			= bool
		name			= string
		address_space		= list(string)
		location		= string
		resource_group_name	= string

		# Optional
		bgp_community			= optional(string)
		dns_servers 			= optional(list(string))
		edge_zone 			= optional(string)
		flow_timeout_in_minutes 	= optional(number)
		ddos_protection_plan		= optional(list(object({
			id	= string
			enable	= string
		})))
		encryption			= optional(list(object({
			enforcement	= string
		})))
		subnets				= optional(list(object({
			enabled		= bool
			name		= string
			address_prefix	= string
			security_group	= optional(string)
		})))

		tags				= optional(map(string))
		})))
}
