resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
	for_each = { for key, value in var.virtual_network_gateway_data : key => value if value.enabled }

		# Required
		dynamic "ip_configuration" {
			for_each = {for key, value in each.value.ip_configuration : key => value}
			
			content {
				# Required
				public_ip_address_id		= var.public_ip_output["${ip_configuration.value.public_ip_address_name}"].id
				subnet_id			= var.subnet_output["${ip_configuration.value.subnet_name}"].id

				# Optional
				name				= ip_configuration.value.name
				private_ip_address_allocation	= ip_configuration.value.private_ip_address_allocation
			}
		}
		location		= each.value.location
		name			= each.value.name
		resource_group_name	= each.value.resource_group_name
		sku			= each.value.sku
		type			= each.value.type

		# Optional
		active_active				= each.value.active_active
		default_local_network_gateway_id	= each.value.default_local_network_gateway_id
		edge_zone				= each.value.edge_zone
		enable_bgp				= each.value.enable_bgp

		dynamic "bgp_settings" {
			for_each = each.value["bgp_settings"] == null ? [] : [1]

			content {
				asn = each.value.bgp_settings.asn
				dynamic "peering_addresses" {
					for_each = each.value["peering_addresses"] == null ? [] : [1]

					content {
						ip_configuration_name = each.value.bgp_settings.peering_addresses.ip_configuration_name
						apipa_addresses = each.value.bgp_settings.peering_addresses.apipa_addresses
						}
				}
				peer_weight = each.value.bgp_settings.peer_weight
			}
		}

		dynamic "custom_route" {
			for_each = each.value["custom_route"] == null ? [] : [1]

			content {
				address_prefixes = each.value.custom_route.address_prefixes
			}
		}

		generation				= each.value.generation
		private_ip_address_enabled		= each.value.private_ip_address_enabled
		tags					= each.value.tags
		# dynamic "vpn_client_configuration" {
		# 	for_each = each.value["vpn_client_configuration"] == null ? [] : [1]

		  
		# }
		vpn_type = each.value.vpn_type
}
