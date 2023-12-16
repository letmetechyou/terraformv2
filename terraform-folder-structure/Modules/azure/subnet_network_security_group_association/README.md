# SUBNET_NETWORK_SECURITY_GROUP_ASSOCIATION VALUES EXAMPLE
subnet_network_security_group_association_data = {
  association1 = {
    enabled                   = true
    subnet_id                 = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/virtualNetworks/vnet-1/subnets/subnet-1"
    network_security_group_id = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/networkSecurityGroups/nsg-1"
  }
  association2 = {
    enabled                   = true
    subnet_name               = "subnet-2"
    network_security_group_key = "nsg-2"
  }
}

# SUBNET_NETWORK_SECURITY_GROUP_ASSOCIATION MODULE REFERENCE
module "subnet_network_security_group_association" {
        source = "./Modules/subnet_network_security_group_association"

        subnet_network_security_group_association_data = var.subnet_network_security_group_association_data
}

# SUBNET_NETWORK_SECURITY_GROUP_ASSOCIATION VARIABLE
variable "subnet_network_security_group_association_data" {
  type = map(object({
    # Required
    enabled                      = bool
    subnet_id                    = optional(string)
    subnet_name                  = optional(string)
    subnet_key                   = optional(string)
    network_security_group_id    = optional(string)
    network_security_group_name  = optional(string)
    network_security_group_key   = optional(string)

    # Optional

    # Optional Dynamic Blocks
  }))
}
