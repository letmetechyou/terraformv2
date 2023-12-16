output "lb_output" {
  value = zipmap(values(azurerm_lb.lb)[*].name, values(azurerm_lb.lb)[*])
}

output "lb_output_names" {
  value = { for key, value in azurerm_lb.lb : value.name => value }
}
