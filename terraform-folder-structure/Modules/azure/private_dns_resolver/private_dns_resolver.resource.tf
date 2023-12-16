resource "azurerm_private_dns_resolver" "private_dns_resolver" {
  for_each = { for key, value in var.private_dns_resolver_data : key => value if value.enabled }

  # Required Arguments
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  location            = each.value.location
  virtual_network_id  = coalesce(
	try(each.value.virtual_network_id, null),
	try(var.virtual_network_output["${each.value.virtual_network_name}"].id, null),
	try(var.virtual_network_output["${each.value.virtual_network_key}"].id, null)
  )

  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
