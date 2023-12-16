output "storage_account_output" {
  value = zipmap(values(azurerm_storage_account.main)[*].name, values(azurerm_storage_account.main)[*])
}

output "storage_account_output_names" {
  value = { for key, value in azurerm_storage_account.main : value.name => value }
}
