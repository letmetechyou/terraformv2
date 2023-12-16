output "lb_probe_output" {
  value = zipmap(values(azurerm_lb_probe.lb_probe)[*].name, values(azurerm_lb_probe.lb_probe)[*])
}

output "lb_probe_output_names" {
  value = { for key, value in azurerm_lb_probe.lb_probe : value.name => value }
}
