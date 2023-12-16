resource "azurerm_lb" "lb" {
  for_each = { for key, value in var.lb_data : key => value if value.enabled }

  # Required Arguments
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  location            = each.value.location


  # Required Blocks 



  # Optional Arguments
  sku                                                = each.value.sku
  edge_zone                                          = each.value.edge_zone
  tags                                               = each.value.tags

  # Optional Dynamic Blocks
  #Use a separate variable and values.  Requires the Name
	dynamic "frontend_ip_configuration" {
		for_each = {for frontend in var.lb_frontend_ip_configuration_data : frontend.name => frontend if frontend.lb_name == each.value.name}
		iterator = frontend

		content {
			# Required
			name							= frontend.value.name

			# Optional
			zones							= frontend.value.zones
			subnet_id						= try(coalesce(
				try(frontend.value.subnet_id, null),
				try(var.subnet_output["${frontend.value.subnet_name}"].id, null),
				try(var.subnet_output["${frontend.value.subnet_key}"].id, null)
			), null)
			gateway_load_balancer_frontend_ip_configuration_id	= frontend.value.gateway_load_balancer_frontend_ip_configuration_id
			private_ip_address					= frontend.value.private_ip_address
			private_ip_address_allocation				= frontend.value.private_ip_address_allocation
			private_ip_address_version				= frontend.value.private_ip_address_version
			public_ip_address_id					= try(coalesce(
				try(frontend.value.public_ip_address_id, null),
				try(var.public_ip_output["${frontend.value.public_ip_address_name}"].id, null),
				try(var.public_ip_output["${frontend.value.public_ip_address_key}"].id, null)
			), null)
			public_ip_prefix_id					= try(coalesce(
				try(frontend.value.public_ip_prefix_id, null),
				try(var.public_ip_prefix_output["${frontend.value.public_ip_prefix_name}"].id, null),
				try(var.public_ip_prefix_output["${frontend.value.public_ip_prefix_key}"].id, null)
			), null)
		}
	}
# USED FOR INLINE CONFIGURATION
#   dynamic "frontend_ip_configuration" {

#     for_each = each.value.frontend_ip_configuration != null ? range(length(each.value.frontend_ip_configuration)) : []

#     content {
#       # Required
#       name = each.value.frontend_ip_configuration[frontend_ip_configuration.key].name

#       # Optional
#       private_ip_address_allocation                      = each.value.frontend_ip_configuration[frontend_ip_configuration.key].private_ip_address_allocation
#       gateway_load_balancer_frontend_ip_configuration_id = each.value.frontend_ip_configuration[frontend_ip_configuration.key].gateway_load_balancer_frontend_ip_configuration_id
#       public_ip_address_id                               = each.value.frontend_ip_configuration[frontend_ip_configuration.key].public_ip_address_id
#       public_ip_prefix_id                                = each.value.frontend_ip_configuration[frontend_ip_configuration.key].public_ip_prefix_id
#       private_ip_address                                 = each.value.frontend_ip_configuration[frontend_ip_configuration.key].private_ip_address
#       zones                                              = each.value.frontend_ip_configuration[frontend_ip_configuration.key].zones
#       private_ip_address_version                         = each.value.frontend_ip_configuration[frontend_ip_configuration.key].private_ip_address_version
#     }
#   }
  lifecycle {
    prevent_destroy = false
  }
}
