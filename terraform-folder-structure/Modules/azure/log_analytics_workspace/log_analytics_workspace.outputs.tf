output "log_analytics_workspace_output" {
  value = zipmap(values(azurerm_log_analytics_workspace.main)[*].name, values(azurerm_log_analytics_workspace.main)[*])
}

output "log_analytics_workspace_output_names" {
  value = { for key, value in azurerm_log_analytics_workspace.main : value.name => value }
}
