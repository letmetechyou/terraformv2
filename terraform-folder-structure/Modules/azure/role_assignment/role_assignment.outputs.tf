output "role_assignment_output" {
  value = zipmap(values(azurerm_role_assignment.role_assignment)[*].name, values(azurerm_role_assignment.role_assignment)[*])
}

output "role_assignment_output_names" {
  value = { for key, value in azurerm_role_assignment.role_assignment : value.name => value }
}
