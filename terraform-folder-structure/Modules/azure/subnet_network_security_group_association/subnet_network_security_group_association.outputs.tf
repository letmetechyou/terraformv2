output "subnet_network_security_group_association_output" {
  value = azurerm_subnet_network_security_group_association.subnet_network_security_group_association[*]
}