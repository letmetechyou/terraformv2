output "private_dns_resolver_forwarding_rule_output" {
  value = zipmap(values(azurerm_private_dns_resolver_forwarding_rule.private_dns_resolver_forwarding_rule)[*].name, values(azurerm_private_dns_resolver_forwarding_rule.private_dns_resolver_forwarding_rule)[*])
}

output "private_dns_resolver_forwarding_rule_output_names" {
  value = { for key, value in azurerm_private_dns_resolver_forwarding_rule.private_dns_resolver_forwarding_rule : value.name => value }
}
