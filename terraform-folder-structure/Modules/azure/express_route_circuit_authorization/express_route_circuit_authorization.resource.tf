resource "azurerm_express_route_circuit_authorization" "express_route_circuit_authorization" {
  for_each = { for key, value in var.express_route_circuit_authorization_data : key => value if value.enabled }

  # Required Arguments
  express_route_circuit_name = each.value.express_route_circuit_name
  resource_group_name        = each.value.resource_group_name
  name                       = each.value.name


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
