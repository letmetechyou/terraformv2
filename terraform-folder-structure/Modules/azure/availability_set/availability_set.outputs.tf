output "availability_set_output" {
  value = zipmap(values(azurerm_availability_set.availability_set)[*].name, values(azurerm_availability_set.availability_set)[*])
}

output "availability_set_output_names" {
  value = { for key, value in azurerm_availability_set.availability_set : value.name => value }
}
