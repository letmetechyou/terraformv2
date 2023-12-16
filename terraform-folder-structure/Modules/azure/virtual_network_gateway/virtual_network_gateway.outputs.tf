output "virtual_network_gateway_output" {
  value = zipmap(keys(azurerm_virtual_network_gateway.virtual_network_gateway), values(azurerm_virtual_network_gateway.virtual_network_gateway)[*])
}
