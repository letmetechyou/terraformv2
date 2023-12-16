# LB VALUES EXAMPLE
lb_data = {
  lb1 = {
    enabled           = true
    resource_group_name = "rg-1"
    name              = "lb-1"
    location          = "East US"

    sku = {
      name     = "Standard"
      tier     = "Regional"
      capacity = 2
    }

    edge_zone = "edge-zone-1"

    tags = {
      environment = "Production"
      app         = "Web"
    }

    frontend_ip_configuration = [
      {
        name = "frontend-1"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "public-ip-1"
        zones                        = ["1", "2", "3"]
      },
      {
        name = "frontend-2"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.0.5"
        zones                        = ["1", "2"]
      },
    ]
  },
  lb2 = {
    enabled           = true
    resource_group_name = "rg-2"
    name              = "lb-2"
    location          = "West US"

    # Other configuration...
  },
}


# LB MODULE REFERENCE
module "lb" {
        source = "./Modules/lb"

        lb_data = var.lb_data
}

# LB VARIABLE
variable "lb_data" {
  type = map(object({
    # Required
    enabled           = bool
    resource_group_name = string
    name              = string
    location          = string

    # Optional
    sku               = optional(string)
    sku_tier          = optional(string)
    edge_zone         = optional(string)
    tags              = optional(map(string))

    # Separate variable for frontend_ip_configuration
    frontend_ip_configuration_data = optional(list(object({
      # Required
      name = string
      lb_name = string

      # Optional
      zones                                              = optional(list(string))
      subnet_id                                          = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address                                 = optional(string)
      private_ip_address_allocation                      = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      public_ip_prefix_id                                = optional(string)
      public_ip_address_name                             = optional(string)
      public_ip_prefix_name                              = optional(string)
      public_ip_address_key                              = optional(string)
      public_ip_prefix_key                               = optional(string)
    })))
  }))
  default = {}
}

# FRONTEND CONFIGURATION VARIABLE
variable "frontend_ip_configuration_data" {
  description = "Frontend IP Configuration data"

  type = map(object({
    lb_name                          = string
    name                             = string
    subnet_name                      = string
    private_ip_address_allocation    = string
    private_ip_address               = string
  }))
  default = {}
}
