output "key_vault_secret_output" {
  value = zipmap(values(azurerm_key_vault_secret.key_vault_secret)[*].name, values(azurerm_key_vault_secret.key_vault_secret)[*])
}

output "key_vault_secret_output_names" {
  value = { for key, value in azurerm_key_vault_secret.key_vault_secret : value.name => value }
}
