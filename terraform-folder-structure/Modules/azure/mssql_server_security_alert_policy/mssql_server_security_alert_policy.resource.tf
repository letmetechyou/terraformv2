resource "azurerm_mssql_server_security_alert_policy" "mssql_server_security_alert_policy" {
  for_each = { for key, value in var.mssql_server_security_alert_policy_data : key => value if value.enabled }

  # Required Arguments
  resource_group_name = each.value.resource_group_name
  state               = each.value.state
  server_name         = coalesce(try(var.mssql_server_output["${each.value.mssql_server_name}"].name, null), try(var.mssql_server_output["${each.value.mssql_server_key}"].name, null))


  # Required Blocks 



  # Optional Arguments
  email_addresses            = each.value.email_addresses
  email_account_admins       = each.value.email_account_admins
  storage_account_access_key = try(coalesce(try(each.value.storage_account_access_key, null), try(var.storage_account_output["${each.value.storage_account_name}"].primary_access_key, null)), null)
  retention_days             = each.value.retention_days
  storage_endpoint           = each.value.storage_endpoint
  disabled_alerts            = each.value.disabled_alerts


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
