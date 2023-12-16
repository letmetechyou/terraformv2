resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  for_each = { for key, value in var.virtual_network_peering_data : key => value if value.enabled }

  # Required Arguments
  resource_group_name       = each.value.resource_group_name
  remote_virtual_network_id = each.value.remote_virtual_network_id
  name                      = each.value.name
  virtual_network_name      = each.value.virtual_network_name


  # Optional Arguments
  allow_gateway_transit        = each.value.allow_gateway_transit
  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  triggers                     = each.value.triggers
  use_remote_gateways          = each.value.use_remote_gateways


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
