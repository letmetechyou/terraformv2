output "route_table_output" {
  value = zipmap(keys(azurerm_route_table.main), values(azurerm_route_table.main)[*])
}

output "route_table_output_names" {
  value = { for key, value in azurerm_route_table.main : value.name => value }
}