output "monitor_diagnostic_setting_output" {
  value = zipmap(values(azurerm_monitor_diagnostic_setting.monitor_diagnostic_setting)[*].name, values(azurerm_monitor_diagnostic_setting.monitor_diagnostic_setting)[*])
}

output "monitor_diagnostic_setting_output_names" {
  value = { for key, value in azurerm_monitor_diagnostic_setting.monitor_diagnostic_setting : value.name => value }
}
