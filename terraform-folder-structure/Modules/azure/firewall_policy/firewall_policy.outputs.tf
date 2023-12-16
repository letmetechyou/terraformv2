output "firewall_policy_output" {
  value = azurerm_firewall_policy.firewall_policy
}

output "firewall_policy_output_names" {
  value = { for key, value in azurerm_firewall_policy.firewall_policy : value.name => value }
}