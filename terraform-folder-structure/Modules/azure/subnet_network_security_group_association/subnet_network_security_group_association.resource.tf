resource "azurerm_subnet_network_security_group_association" "subnet_network_security_group_association" {
  for_each = { for key, value in var.subnet_network_security_group_association_data : key => value if value.enabled }

  # Required Arguments
        subnet_id = coalesce(
		try(each.value.subnet_id, null),
		try(var.subnet_output["${each.value.subnet_name}"].id, null),
		try(var.subnet_output["${each.value.subnet_key}"].id, null)
	)
	network_security_group_id = coalesce(
		try(each.value.network_security_group_id, null),
		try(var.network_security_group_output["${each.value.network_security_group_name}"].id, null),
		try(var.network_security_group_output["${each.value.network_security_group_key}"].id, null)
	)

  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
