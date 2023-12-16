output "private_endpoint_output" {
  value = zipmap(values(azurerm_private_endpoint.private_endpoint)[*].name, values(azurerm_private_endpoint.private_endpoint)[*])
}

output "private_endpoint_output_names" {
  value = { for key, value in azurerm_private_endpoint.private_endpoint : value.name => value }
}
