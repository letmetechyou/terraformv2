# NETWORK_INTERFACE_BACKEND_ADDRESS_POOL_ASSOCIATION VALUES EXAMPLE
network_interface_backend_address_pool_association_data = {
  association1 = {
    enabled                 = true
    ip_configuration_name   = "config-1"
    network_interface_id    = "nic-1"
    backend_address_pool_id = "pool-1"
  },
  association2 = {
    enabled                 = true
    ip_configuration_name   = "config-2"
    network_interface_id    = "nic-2"
    backend_address_pool_id = "pool-2"
  },
  # Add more associations as needed
}

# NETWORK_INTERFACE_BACKEND_ADDRESS_POOL_ASSOCIATION MODULE REFERENCE
module "network_interface_backend_address_pool_association" {
        source = "./Modules/network_interface_backend_address_pool_association"

        network_interface_backend_address_pool_association_data = var.network_interface_backend_address_pool_association_data
}

# NETWORK_INTERFACE_BACKEND_ADDRESS_POOL_ASSOCIATION VARIABLE
variable "network_interface_backend_address_pool_association_data" {
  type = map(object({
    # Required
    enabled                 = bool
    ip_configuration_name   = string
    network_interface_id    = string
    backend_address_pool_id = string

    # Optional
    # Add optional attributes if needed
  }))
  default = {}
}
