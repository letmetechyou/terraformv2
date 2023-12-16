resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  for_each = { for key, value in var.monitor_diagnostic_setting_data : key => value if value.enabled }

  # Required Arguments
  name               = each.value.name
  target_resource_id = each.value.target_resource_id


  # Required Blocks 



  # Optional Arguments
  log_analytics_workspace_id     = each.value.log_analytics_workspace_id
  storage_account_id             = each.value.storage_account_id
  eventhub_name                  = each.value.eventhub_name
  eventhub_authorization_rule_id = each.value.eventhub_authorization_rule_id
  log_analytics_destination_type = each.value.log_analytics_destination_type
  partner_solution_id            = each.value.partner_solution_id


  # Optional Dynamic Blocks
  dynamic "metric" {

    for_each = each.value.metric != null ? range(length(each.value.metric)) : []

    content {
      # Required
      category = each.value.metric[metric.key].category

      # Optional
      enabled          = each.value.metric[metric.key].enabled

      # Optional Dynamic Blocks
        dynamic "retention_policy" {

		for_each = each.value.metric[metric.key].retention_policy != null ? [1] : []

		content {
		# Required
		enabled = each.value.metric[metric.key].retention_policy.enabled

		# Optional
		days = each.value.metric[metric.key].retention_policy.days
		}
	}
    }
  }

  dynamic "enabled_log" {

    for_each = each.value.enabled_log != null ? range(length(each.value.enabled_log)) : []

    content {
      # Required

      # Optional
      category_group   = each.value.enabled_log[enabled_log.key].category_group
      category         = each.value.enabled_log[enabled_log.key].category

      # Optional Dynamic Blocks
  #       dynamic "retention_policy" {

	# 	for_each = each.value.enabled_log[enabled_log.key].retention_policy != null ? [1] : []

	# 	content {
	# 	# Required
	# 	enabled = each.value.enabled_log[enabled_log.key].retention_policy.enabled

	# 	# Optional
	# 	days = each.value.enabled_log[enabled_log.key].retention_policy.days
	# 	}
	# }
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}
