output "key_vault_access_policy_output" {
  value = zipmap(keys(azurerm_key_vault_access_policy.main), values(azurerm_key_vault_access_policy.main)[*])
}