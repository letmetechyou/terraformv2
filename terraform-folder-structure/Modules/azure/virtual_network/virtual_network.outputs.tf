output "virtual_network_output" {
  value = zipmap(keys(azurerm_virtual_network.virtual_network), values(azurerm_virtual_network.virtual_network)[*])
}

output "virtual_network_output_names" {
  value = { for key, value in azurerm_virtual_network.virtual_network : value.name => value }
}