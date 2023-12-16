resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  for_each = { for key, value in var.lb_backend_address_pool_data : key => value if value.enabled }

  # Required Arguments
  name            = each.value.name
  loadbalancer_id = coalesce(
				try(each.value.loadbalancer_id, null),
				try(var.lb_output["${each.value.loadbalancer_name}"].id, null),
				try(var.lb_output["${each.value.loadbalancer_key}"].id, null)
			)


  # Required Blocks 



  # Optional Arguments
  virtual_network_id = each.value.virtual_network_id


  # Optional Dynamic Blocks
  dynamic "tunnel_interface" {

    for_each = each.value.tunnel_interface != null ? range(length(each.value.tunnel_interface)) : []

    content {
      # Required
      port       = each.value.tunnel_interface[tunnel_interface.key].port
      identifier = each.value.tunnel_interface[tunnel_interface.key].identifier
      protocol   = each.value.tunnel_interface[tunnel_interface.key].protocol
      type       = each.value.tunnel_interface[tunnel_interface.key].type

      # Optional
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
