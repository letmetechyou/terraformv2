output "express_route_circuit_authorization_output" {
  value = zipmap(values(azurerm_express_route_circuit_authorization.express_route_circuit_authorization)[*].name, values(azurerm_express_route_circuit_authorization.express_route_circuit_authorization)[*])
}

output "express_route_circuit_authorization_output_names" {
  value = { for key, value in azurerm_express_route_circuit_authorization.express_route_circuit_authorization : value.name => value }
}
