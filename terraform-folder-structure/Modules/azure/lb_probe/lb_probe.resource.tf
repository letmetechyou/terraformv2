resource "azurerm_lb_probe" "lb_probe" {
  for_each = { for key, value in var.lb_probe_data : key => value if value.enabled }

  # Required Arguments
  port            = each.value.port
  loadbalancer_id = coalesce(
				try(each.value.loadbalancer_id, null),
				try(var.lb_output["${each.value.loadbalancer_name}"].id, null),
				try(var.lb_output["${each.value.loadbalancer_key}"].id, null)
			)
  name            = each.value.name


  # Required Blocks 



  # Optional Arguments
  interval_in_seconds = each.value.interval_in_seconds
  request_path        = each.value.request_path
  protocol            = each.value.protocol
  probe_threshold     = each.value.probe_threshold
  number_of_probes    = each.value.number_of_probes


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
