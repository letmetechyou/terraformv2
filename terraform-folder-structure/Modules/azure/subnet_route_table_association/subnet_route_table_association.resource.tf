resource "azurerm_subnet_route_table_association" "main" {
	for_each = { for key, value in var.subnet_route_table_association_data : key => value if value.enabled && value.route_table_id != null || value.route_table_name != null || value.route_table_key != null }

        subnet_id = coalesce(
		try(each.value.subnet_id, null),
		try(var.subnet_output["${each.value.name}"].id, null),
		try(var.subnet_output["${each.value.subnet_name}"].id, null),
		try(var.subnet_output["${each.value.subnet_key}"].id, null)
	)
	route_table_id = coalesce(
		try(each.value.route_table_id, null),
		try(var.route_table_output["${each.value.route_table_name}"].id, null),
		try(var.route_table_output["${each.value.route_table_key}"].id, null)
	)
	# network_security_group_id = coalesce(
	# 	each.value.network_security_group_id,
	# 	var.network_security_group_output["${each.value.network_security_group_name}"].id
	# )
}

# { for key, value in var.subnet_data[0] : key => value if value.enabled && value.network_security_group != null}
#module.network_security_group.network_security_group_output_names["${var.subnet_data[0]["spoke3"].network_security_group.name}"]
