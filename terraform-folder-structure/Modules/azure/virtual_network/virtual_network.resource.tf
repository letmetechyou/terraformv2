resource "azurerm_virtual_network" "virtual_network" {
	for_each = { for key, value in var.virtual_network_data : key => value if value.enabled }

	# Required
	name                = each.value.name
	resource_group_name = each.value.resource_group_name
	address_space       = each.value.address_space
	location            = each.value.location

	# Optional
	bgp_community			= each.value.bgp_community
	dns_servers 			= each.value.dns_servers
	edge_zone 			= each.value.edge_zone
	flow_timeout_in_minutes 	= each.value.flow_timeout_in_minutes

	dynamic "ddos_protection_plan" {
		for_each = each.value["ddos_protection_plan"] == null ? [] : [1]

		content {
			id     = each.value.ddos_protection_plan.id
			enable = each.value.ddos_protection_plan.enable
		}
	}

	# Optional encryption dynamic block
	dynamic "encryption" {
		for_each = each.value["encryption"] == null ? [] : [1]

		content {
			enforcement = each.value.encryption.enforcement
		}
	}

	# Optional subnet dynamic block
		dynamic "subnet" {
			for_each = each.value.subnets == null ? [] : {for subnet in each.value.subnet : subnet.name => subnet if subnet.enabled}

		content {
			name           = subnet.value.name
			address_prefix = subnet.value.address_prefix
			security_group = subnet.value.security_group
		}
	}

	tags = each.value.tags
}
