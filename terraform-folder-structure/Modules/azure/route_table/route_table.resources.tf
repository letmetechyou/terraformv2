

resource "azurerm_route_table" "main" {
	for_each = { for key, value in var.route_table_data : key => value if value.enabled }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.existing_resource_group_name
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation

  dynamic route {
	for_each =  {for key, value in each.value.routes : key => value}
    content {
      name                   = route.value.name
      address_prefix        = route.value.address_prefix
      next_hop_type         = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }

    }
  }