output "firewall_policy_rule_collection_group_output" {
  value       = zipmap(keys(azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_group), values(azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_group))
}

output "firewall_policy_rule_collection_group_output_names" {
  value       = { for key, value in azurerm_firewall_policy_rule_collection_group.firewall_policy_rule_collection_group : value.name => value }
}
