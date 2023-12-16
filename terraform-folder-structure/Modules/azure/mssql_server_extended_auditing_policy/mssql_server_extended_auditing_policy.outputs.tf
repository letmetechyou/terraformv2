output "mssql_server_extended_auditing_policy_output" {
  value = zipmap(values(azurerm_mssql_server_extended_auditing_policy.mssql_server_extended_auditing_policy)[*].server_id, values(azurerm_mssql_server_extended_auditing_policy.mssql_server_extended_auditing_policy)[*])
}

output "mssql_server_extended_auditing_policy_output_names" {
  value = { for key, value in azurerm_mssql_server_extended_auditing_policy.mssql_server_extended_auditing_policy : value.server_id => value }
}
