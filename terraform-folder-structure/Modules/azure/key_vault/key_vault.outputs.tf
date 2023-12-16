output "key_vault_output" {
  value = zipmap(keys(azurerm_key_vault.main), values(azurerm_key_vault.main)[*])
}

output "key_vault_output_output_names" {
  value = { for key, value in azurerm_key_vault.main : value.name => value }
}