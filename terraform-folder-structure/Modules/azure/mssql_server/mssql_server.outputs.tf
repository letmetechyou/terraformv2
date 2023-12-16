output "mssql_server_output" {
  value = zipmap(values(azurerm_mssql_server.mssql_server)[*].name, values(azurerm_mssql_server.mssql_server)[*])
}

output "mssql_server_output_names" {
  value = { for key, value in azurerm_mssql_server.mssql_server : value.name => value }
}
