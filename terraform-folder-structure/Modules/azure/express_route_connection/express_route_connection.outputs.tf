output "express_route_connection_output" {
  value = zipmap(values(azurerm_express_route_connection.express_route_connection)[*].name, values(azurerm_express_route_connection.express_route_connection)[*])
}

output "express_route_connection_output_names" {
  value = { for key, value in azurerm_express_route_connection.express_route_connection : value.name => value }
}
