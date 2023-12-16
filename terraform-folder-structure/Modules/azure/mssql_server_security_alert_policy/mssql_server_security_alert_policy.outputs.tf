output "mssql_server_security_alert_policy_output" {
  value = zipmap(values(azurerm_mssql_server_security_alert_policy.mssql_server_security_alert_policy)[*].server_name, values(azurerm_mssql_server_security_alert_policy.mssql_server_security_alert_policy)[*])
}

output "mssql_server_security_alert_policy_output_names" {
  value = { for key, value in azurerm_mssql_server_security_alert_policy.mssql_server_security_alert_policy : value.server_name => value }
}
