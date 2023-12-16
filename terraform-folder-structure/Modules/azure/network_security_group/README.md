# NETWORK_SECURITY_GROUP VALUES EXAMPLE
network_security_group_data = {
  nsg1 = {
    enabled            = true
    name               = "nsg-1"
    resource_group_name = "rg-1"
    location           = "East US"
    tags = {
      environment = "Dev"
    }
    security_rule = [
      {
        priority  = 100
        direction = "Inbound"
        protocol  = "TCP"
        access    = "Allow"
        name      = "rule-1"
        source_port_ranges = ["22", "80"]
        destination_port_range = "8080"
        description = "Allow SSH and HTTP"
        source_address_prefixes = ["10.0.0.0/24"]
        destination_address_prefixes = ["0.0.0.0/0"]
      },
      {
        priority  = 200
        direction = "Outbound"
        protocol  = "UDP"
        access    = "Deny"
        name      = "rule-2"
        source_port_ranges = ["500"]
        destination_port_range = "0-65535"
        description = "Deny UDP traffic"
        source_address_prefixes = ["0.0.0.0/0"]
        destination_address_prefixes = ["10.0.0.0/16"]
      },
    ]
  },
  nsg2 = {
    enabled            = true
    name               = "nsg-2"
    resource_group_name = "rg-2"
    location           = "West US"
    tags = {
      environment = "Prod"
    }
    security_rule = [
      {
        priority  = 100
        direction = "Inbound"
        protocol  = "TCP"
        access    = "Allow"
        name      = "rule-1"
        source_port_ranges = ["22"]
        destination_port_range = "8080"
        description = "Allow SSH"
        source_address_prefixes = ["192.168.1.0/24"]
        destination_address_prefixes = ["0.0.0.0/0"]
      },
    ]
  },
}

# NETWORK_SECURITY_GROUP MODULE REFERENCE
module "network_security_group" {
        source = "./Modules/network_security_group"

        network_security_group_data = var.network_security_group_data
}

# NETWORK_SECURITY_GROUP VARIABLE
variable "network_security_group_data" {
  type = map(object({
    # Required
    enabled            = bool
    name               = string
    resource_group_name = string
    location           = string

    # Optional
    tags = optional(map(string))

    # Optional Dynamic Blocks
    security_rule = optional(list(object({
      # Required
      priority  = number
      direction = string
      protocol  = string
      access    = string
      name      = string

      # Optional
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      description                                = optional(string)
      source_address_prefix                      = optional(string)
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      source_address_prefixes                    = optional(list(string))
      source_port_range                          = optional(string)
    })))
  }))
}
