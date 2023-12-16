# EXPRESS_ROUTE_CIRCUIT_AUTHORIZATION VALUES EXAMPLE
express_route_circuit_authorization_data = {
    authorization1 = {
      enabled                  = true
      express_route_circuit_name = "circuit-name-1"
      resource_group_name      = "rg-1"
      name                     = "authorization-1"
    }
    authorization2 = {
      enabled                  = true
      express_route_circuit_name = "circuit-name-2"
      resource_group_name      = "rg-2"
      name                     = "authorization-2"
    }
}

# EXPRESS_ROUTE_CIRCUIT_AUTHORIZATION MODULE REFERENCE
module "express_route_circuit_authorization" {
  source = "./Modules/express_route_circuit_authorization"

  express_route_circuit_authorization_data = var.express_route_circuit_authorization_data
}

# EXPRESS_ROUTE_CIRCUIT_AUTHORIZATION VARIABLE
variable "express_route_circuit_authorization_data" {
  type = map(object({
    # Required
    enabled                  = bool
    express_route_circuit_name = string
    resource_group_name      = string
    name                     = string

    # Optional

    # Optional Dynamic Blocks
  }))
}
