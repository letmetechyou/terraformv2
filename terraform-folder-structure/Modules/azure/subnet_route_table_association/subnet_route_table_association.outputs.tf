output "subnet_route_table_association_output" {
	value = values(azurerm_subnet_route_table_association.main)[*]
}
