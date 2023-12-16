# LB_BACKEND_ADDRESS_POOL VALUES EXAMPLE
lb_backend_address_pool_data = {
  pool1 = {
    enabled             = true
    name                = "backend-pool-1"
    loadbalancer_id     = "lb-id-1"
    virtual_network_id  = "vnet-id-1"
    
    tunnel_interface = [
      {
        port       = 8080
        identifier = "tunnel-1"
        protocol   = "TCP"
        type       = "Site-to-Site"
      },
    ]
  },
  pool2 = {
    enabled             = true
    name                = "backend-pool-2"
    loadbalancer_id     = "lb-id-2"
    virtual_network_id  = "vnet-id-2"
    
    tunnel_interface = [
      {
        port       = 9090
        identifier = "tunnel-2"
        protocol   = "UDP"
        type       = "Point-to-Site"
      },
    ]
  },
}

# LB_BACKEND_ADDRESS_POOL MODULE REFERENCE
module "lb_backend_address_pool" {
        source = "./Modules/lb_backend_address_pool"

        lb_backend_address_pool_data = var.lb_backend_address_pool_data
}

# LB_BACKEND_ADDRESS_POOL VARIABLE
variable "lb_backend_address_pool_data" {
  type = map(object({
    # Required
    enabled         = bool
    name            = string
    loadbalancer_id = string

    # Optional
    virtual_network_id = optional(string)

    # Optional Dynamic Blocks
    tunnel_interface = optional(list(object({
      # Required
      port       = number
      identifier = string
      protocol   = string
      type       = string

      # Optional
    })))
  }))
}
