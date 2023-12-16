output "network_interface_output" {
	value = zipmap(values(azurerm_network_interface.network_interface)[*].name, values(azurerm_network_interface.network_interface)[*])

}

output "network_interface_output_names" {
  value = { for key, value in azurerm_network_interface.network_interface : value.name => value }
}