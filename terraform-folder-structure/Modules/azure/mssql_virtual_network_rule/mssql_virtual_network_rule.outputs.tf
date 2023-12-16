output "mssql_virtual_network_rule_output" {
  value = zipmap(values(azurerm_mssql_virtual_network_rule.mssql_virtual_network_rule)[*].name, values(azurerm_mssql_virtual_network_rule.mssql_virtual_network_rule)[*])
}

output "mssql_virtual_network_rule_output_names" {
  value = { for key, value in azurerm_mssql_virtual_network_rule.mssql_virtual_network_rule : value.name => value }
}
