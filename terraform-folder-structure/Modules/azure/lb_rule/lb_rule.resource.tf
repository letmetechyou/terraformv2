resource "azurerm_lb_rule" "lb_rule" {
  for_each = { for key, value in var.lb_rule_data : key => value if value.enabled }

  # Required Arguments
  name                           = each.value.name
  frontend_port                  = each.value.frontend_port
  protocol                       = each.value.protocol
  loadbalancer_id = coalesce(
				try(each.value.loadbalancer_id, null),
				try(var.lb_output["${each.value.loadbalancer_name}"].id, null),
				try(var.lb_output["${each.value.loadbalancer_key}"].id, null)
			)  
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_port                   = each.value.backend_port


  # Required Blocks 



  # Optional Arguments
  probe_id                 = try(coalesce(
			try(each.value.probe_id, null),
			try(var.lb_probe_output["${each.value.probe_name}"].id, null),
			try(var.lb_probe_output["${each.value.probe_key}"].id, null)
			), null) 
  disable_outbound_snat    = each.value.disable_outbound_snat
  idle_timeout_in_minutes  = each.value.idle_timeout_in_minutes
  load_distribution        = each.value.load_distribution
  backend_address_pool_ids = try(coalesce(
			try(each.value.backend_address_pool_ids, null),
			try([for name in each.value.backend_address_pool_names : var.lb_backend_address_pool_output["${name}"].id], null),
			try([for key in each.value.backend_address_pool_keys : var.lb_backend_address_pool_output["${key}"].id], null)
			), null) 
  enable_tcp_reset         = each.value.enable_tcp_reset
  enable_floating_ip       = each.value.enable_floating_ip

  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
