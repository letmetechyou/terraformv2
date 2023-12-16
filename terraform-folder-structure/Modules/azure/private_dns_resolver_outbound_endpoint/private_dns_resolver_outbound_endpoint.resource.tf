resource "azurerm_private_dns_resolver_outbound_endpoint" "private_dns_resolver_outbound_endpoint" {
  for_each = { for key, value in var.private_dns_resolver_outbound_endpoint_data : key => value if value.enabled }

  # Required Arguments
  private_dns_resolver_id = coalesce(
	try(each.value.private_dns_resolver_id, null),
	try(var.private_dns_resolver_output["${each.value.private_dns_resolver_name}"].id, null),
	try(var.private_dns_resolver_output["${each.value.private_dns_resolver_key}"].id, null)
  )

  name                    = each.value.name
  location                = each.value.location
  subnet_id               = coalesce(
	try(each.value.subnet_id, null),
	try(var.subnet_output["${each.value.subnet_name}"].id, null),
	try(var.subnet_output["${each.value.subnet_key}"].id, null)
  )


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
