output "management_lock_output" {
  value = zipmap(values(azurerm_management_lock.management_lock)[*].name, values(azurerm_management_lock.management_lock)[*])
}

output "management_lock_output_names" {
  value = { for key, value in azurerm_management_lock.management_lock : value.name => value }
}
