output "virtual_network_peering_output" {
  value = zipmap(values(azurerm_virtual_network_peering.virtual_network_peering)[*].name, values(azurerm_virtual_network_peering.virtual_network_peering)[*])
}

output "virtual_network_peering_output_names" {
  value = { for key, value in azurerm_virtual_network_peering.virtual_network_peering : value.name => value }
}
