resource "azurerm_private_dns_resolver_virtual_network_link" "private_dns_resolver_virtual_network_link" {
  for_each = { for key, value in var.private_dns_resolver_virtual_network_link_data : key => value if value.enabled }

  # Required Arguments
  name                      = each.value.name
  virtual_network_id        = coalesce(
			try(each.value.virtual_network_id, null),
			try(var.virtual_network_output["${each.value.virtual_network_name}"].id, null),
			try(var.virtual_network_output["${each.value.virtual_network_key}"].id, null)
  )
  dns_forwarding_ruleset_id = coalesce(
			try(each.value.dns_forwarding_ruleset_id, null),
			try(var.private_dns_resolver_dns_forwarding_ruleset_output["${each.value.dns_forwarding_ruleset_name}"].id, null),
			try(var.private_dns_resolver_dns_forwarding_ruleset_output["${each.value.dns_forwarding_ruleset_key}"].id, null)
  )


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
