resource "azurerm_mssql_server_extended_auditing_policy" "mssql_server_extended_auditing_policy" {
  for_each = { for key, value in var.mssql_server_extended_auditing_policy_data : key => value if value.enabled_policy }

  # Required Arguments
  server_id = coalesce(try(each.value.mssql_server_id, null), try(var.mssql_server_output["${each.value.mssql_server_name}"].id, null), try(var.mssql_server_output["${each.value.mssql_server_key}"].id, null)
  )

  # Required Blocks 



  # Optional Arguments
  storage_account_access_key              = each.value.storage_account_access_key
  retention_in_days                       = each.value.retention_in_days
  storage_account_subscription_id         = each.value.storage_account_subscription_id
  log_monitoring_enabled                  = each.value.log_monitoring_enabled
  enabled                                 = each.value.enabled
  storage_account_access_key_is_secondary = each.value.storage_account_access_key_is_secondary
  storage_endpoint                        = each.value.storage_endpoint


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
