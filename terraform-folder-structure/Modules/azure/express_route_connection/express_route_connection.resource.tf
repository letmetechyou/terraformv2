resource "azurerm_express_route_connection" "express_route_connection" {
  for_each = { for key, value in var.express_route_connection_data : key => value if value.enabled }

  # Required Arguments
  express_route_gateway_id         = each.value.express_route_gateway_id
  express_route_circuit_peering_id = each.value.express_route_circuit_peering_id
  name                             = each.value.name


  # Required Blocks 



  # Optional Arguments
  express_route_gateway_bypass_enabled = each.value.express_route_gateway_bypass_enabled
  routing_weight                       = each.value.routing_weight
  authorization_key                    = each.value.authorization_key
  enable_internet_security             = each.value.enable_internet_security


  # Optional Dynamic Blocks
  dynamic "routing" {

    for_each = each.value.routing != null ? range(length(each.value.routing)) : []

    content {
      # Required

      # Optional
      outbound_route_map_id     = each.value.routing[routing.key].outbound_route_map_id
      inbound_route_map_id      = each.value.routing[routing.key].inbound_route_map_id
      associated_route_table_id = each.value.routing[routing.key].associated_route_table_id
      #block - propagated_route_table    = each.value.routing[routing.key].propagated_route_table
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
