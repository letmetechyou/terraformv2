output "network_security_group_output" {
  value = zipmap(values(azurerm_network_security_group.network_security_group)[*].name, values(azurerm_network_security_group.network_security_group)[*])
}

output "network_security_group_output_names" {
  value = { for key, value in azurerm_network_security_group.network_security_group : value.name => value }
}
