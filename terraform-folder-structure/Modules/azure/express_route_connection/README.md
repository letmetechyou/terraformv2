# EXAMPLE FOR VALUES
variable "express_route_connection_data" {
  default = {
    connection1 = {
      enabled                           = true
      express_route_gateway_id         = "gateway-id-1"
      express_route_circuit_peering_id = "peering-id-1"
      name                             = "connection-1"
      express_route_gateway_bypass_enabled = true
      routing_weight                       = 1
      authorization_key                    = "secret-key-1"
      enable_internet_security             = true
      routing = [
        {
          outbound_route_map_id     = "outbound-map-id-1"
          inbound_route_map_id      = "inbound-map-id-1"
          associated_route_table_id = "route-table-id-1"
        },
        {
          outbound_route_map_id     = "outbound-map-id-2"
          inbound_route_map_id      = "inbound-map-id-2"
          associated_route_table_id = "route-table-id-2"
        },
      ]
    },
    connection2 = {
      enabled                           = true
      express_route_gateway_id         = "gateway-id-2"
      express_route_circuit_peering_id = "peering-id-2"
      name                             = "connection-2"
      express_route_gateway_bypass_enabled = false
      routing_weight                       = 2
      authorization_key                    = "secret-key-2"
      enable_internet_security             = false
      routing = [
        {
          outbound_route_map_id     = "outbound-map-id-3"
          inbound_route_map_id      = "inbound-map-id-3"
          associated_route_table_id = "route-table-id-3"
        },
      ]
    },
  }
}

# EXAMPLE MODULE
module "express_route_connection" {
  source = "./Modules/express_route_connection"

  express_route_connection_data = var.express_route_connection_data
}

# EXAMPLE VARIABLE
variable "express_route_connection_data" {
  type = map(object({
    # Required
    enabled                           = bool
    express_route_gateway_id         = string
    express_route_circuit_peering_id = string
    name                             = string

    # Optional
    express_route_gateway_bypass_enabled = optional(bool)
    routing_weight                       = optional(number)
    authorization_key                    = optional(string)
    enable_internet_security             = optional(bool)

    # Optional Dynamic Block
    routing = optional(list(object({
      # Required

      # Optional
      outbound_route_map_id     = optional(string)
      inbound_route_map_id      = optional(string)
      associated_route_table_id = optional(string)
      #block - propagated_route_table    = optional(string)
    })))
  }))
}
