output "resource_group_output" {
	value = zipmap(values(azurerm_resource_group.resource_group)[*].name, values(azurerm_resource_group.resource_group)[*])
}

output "resource_group_output_names" {
  value = { for key, value in azurerm_resource_group.resource_group : value.name => value }
}