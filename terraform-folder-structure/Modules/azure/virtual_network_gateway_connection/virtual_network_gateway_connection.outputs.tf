output "virtual_network_gateway_connection_output" {
  value = zipmap(values(azurerm_virtual_network_gateway_connection.virtual_network_gateway_connection)[*].name, values(azurerm_virtual_network_gateway_connection.virtual_network_gateway_connection)[*])
}

output "virtual_network_gateway_connection_output_names" {
  value = { for key, value in azurerm_virtual_network_gateway_connection.virtual_network_gateway_connection : value.name => value }
}
