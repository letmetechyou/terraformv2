resource "azurerm_subnet" "subnet" {
	for_each = { for key, value in var.subnet_data : key => value if value.enabled }
		
	# Required
	name			= each.value.name
	resource_group_name	= each.value.resource_group_name
	virtual_network_name	= each.value.virtual_network_name
	address_prefixes	= each.value.address_prefixes

	# Optional

	dynamic "delegation" {
		for_each = each.value["delegation"] == null ? [] : [1]

		content {
			name = each.value.delegation.name
			service_delegation {
				name = each.value.delegation.service_delegation.name
				actions = each.value.delegation.service_delegation.actions
			}
		}
	}
	private_endpoint_network_policies_enabled	= each.value.private_endpoint_network_policies_enabled
	private_link_service_network_policies_enabled	= each.value.private_link_service_network_policies_enabled
	service_endpoints				= each.value.service_endpoints
	service_endpoint_policy_ids			= each.value.service_endpoint_policy_ids

}
