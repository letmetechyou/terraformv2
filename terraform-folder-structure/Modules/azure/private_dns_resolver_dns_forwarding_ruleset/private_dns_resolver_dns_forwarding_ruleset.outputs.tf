output "private_dns_resolver_dns_forwarding_ruleset_output" {
  value = zipmap(values(azurerm_private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset)[*].name, values(azurerm_private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset)[*])
}

output "private_dns_resolver_dns_forwarding_ruleset_output_names" {
  value = { for key, value in azurerm_private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset : value.name => value }
}
