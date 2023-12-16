output "lb_rule_output" {
  value = zipmap(values(azurerm_lb_rule.lb_rule)[*].name, values(azurerm_lb_rule.lb_rule)[*])
}

output "lb_rule_output_names" {
  value = { for key, value in azurerm_lb_rule.lb_rule : value.name => value }
}
