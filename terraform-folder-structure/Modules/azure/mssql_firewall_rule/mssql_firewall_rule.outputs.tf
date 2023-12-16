output "mssql_firewall_rule_output" {
  value = zipmap(values(azurerm_mssql_firewall_rule.mssql_firewall_rule)[*].name, values(azurerm_mssql_firewall_rule.mssql_firewall_rule)[*])
}

output "mssql_firewall_rule_output_names" {
  value = { for key, value in azurerm_mssql_firewall_rule.mssql_firewall_rule : value.name => value }
}
