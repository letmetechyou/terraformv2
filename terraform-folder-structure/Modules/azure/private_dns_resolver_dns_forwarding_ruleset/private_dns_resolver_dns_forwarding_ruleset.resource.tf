resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "private_dns_resolver_dns_forwarding_ruleset" {
  for_each = { for key, value in var.private_dns_resolver_dns_forwarding_ruleset_data : key => value if value.enabled }

  # Required Arguments
  private_dns_resolver_outbound_endpoint_ids = coalesce(
	try(each.value.private_dns_resolver_outbound_endpoint_ids, null),
	try([for name in each.value.private_dns_resolver_outbound_endpoint_names : var.private_dns_resolver_outbound_endpoint_output["${name}"].id], null),
	try([for key in each.value.private_dns_resolver_outbound_endpoint_keys : var.private_dns_resolver_outbound_endpoint_output["${key}"].id], null)
  )
  resource_group_name                        = each.value.resource_group_name
  name                                       = each.value.name
  location                                   = each.value.location


  # Required Blocks 



  # Optional Arguments
  tags = each.value.tags


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
