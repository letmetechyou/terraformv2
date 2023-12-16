resource "azurerm_network_interface_backend_address_pool_association" "network_interface_backend_address_pool_association" {
  for_each = { for key, value in var.network_interface_backend_address_pool_association_data : key => value if value.enabled }

  # Required Arguments
  ip_configuration_name   = each.value.ip_configuration_name
  network_interface_id    = coalesce(
	try(each.value.network_interface_id, null),
	try(var.network_interface_output["${each.value.network_interface_name}"].id, null),
	try(var.network_interface_output["${each.value.network_interface_key}"].id, null)
  )
  backend_address_pool_id = coalesce(
	try(each.value.backend_address_pool_id, null),
	try(var.lb_backend_address_pool_output["${each.value.backend_address_pool_name}"].id, null),
	try(var.lb_backend_address_pool_output["${each.value.backend_address_pool_key}"].id, null)
  )


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
