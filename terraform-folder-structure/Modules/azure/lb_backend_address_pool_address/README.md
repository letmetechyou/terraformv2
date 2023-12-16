# LB_BACKEND_ADDRESS_POOL_ADDRESS VALUES EXAMPLE
lb_backend_address_pool_address_data = {
  address1 = {
    enabled                         = true
    name                            = "address-1"
    backend_address_pool_id         = "backend-pool-id-1"
    backend_address_ip_configuration_id = "ip-config-id-1"
    ip_address                      = "10.0.0.1"
    virtual_network_id              = "vnet-id-1"
  },
  address2 = {
    enabled                         = true
    name                            = "address-2"
    backend_address_pool_id         = "backend-pool-id-2"
    backend_address_ip_configuration_id = "ip-config-id-2"
    ip_address                      = "10.0.0.2"
    virtual_network_id              = "vnet-id-2"
  },
}

# LB_BACKEND_ADDRESS_POOL_ADDRESS MODULE REFERENCE
module "lb_backend_address_pool_address" {
        source = "./Modules/lb_backend_address_pool_address"

        lb_backend_address_pool_address_data = var.lb_backend_address_pool_address_data
}

# LB_BACKEND_ADDRESS_POOL_ADDRESS VARIABLE
variable "lb_backend_address_pool_address_data" {
  type = map(object({
    # Required
    enabled                 = bool
    name                    = string
    backend_address_pool_id = string

    # Optional
    backend_address_ip_configuration_id = optional(string)
    ip_address                          = optional(string)
    virtual_network_id                  = optional(string)

    # Optional Dynamic Blocks
  }))
}
