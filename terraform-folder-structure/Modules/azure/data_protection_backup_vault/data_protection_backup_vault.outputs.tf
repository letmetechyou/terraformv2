output "data_protection_backup_vault_output" {
  value = zipmap(keys(azurerm_data_protection_backup_vault.data_protection_backup_vault), values(azurerm_data_protection_backup_vault.data_protection_backup_vault)[*])
}

output "data_protection_backup_vault_output_names" {
  value = { for key, value in azurerm_data_protection_backup_vault.data_protection_backup_vault : value.name => value }
}