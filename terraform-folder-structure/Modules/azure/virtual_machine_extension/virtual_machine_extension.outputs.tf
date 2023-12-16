# output "virtual_machine_extension_output" {
#   value = zipmap(values(azurerm_virtual_machine_extension.virtual_machine_extension)[*].name, values(azurerm_virtual_machine_extension.virtual_machine_extension)[*])
# }

# output "virtual_machine_extension_output_names" {
#   value = { for key, value in azurerm_virtual_machine_extension.virtual_machine_extension : value.name => value }
# }


output "virtual_machine_extension_output" {
  value = { for key, value in azurerm_virtual_machine_extension.virtual_machine_extension : "${key}-${value.type}" => value }
}

# output "virtual_machine_extension_output_names" { 
#   value = { for key, value in azurerm_virtual_machine_extension.virtual_machine_extension : value.name => value } #causes duplicate keys
# } 
