# MSSQL_SERVER_EXTENDED_AUDITING_POLICY VALUES EXAMPLE
mssql_server_extended_auditing_policy_data = {
  audit_policy1 = {
    enabled                                 = true
    server_id                               = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Sql/servers/sql-server-1"
    storage_account_access_key              = "your-storage-account-access-key"
    retention_in_days                       = 30
    storage_account_subscription_id         = "/subscriptions/subscription-id"
    log_monitoring_enabled                  = true
    storage_account_access_key_is_secondary = false
    storage_endpoint                        = "https://your-storage-account.blob.core.windows.net/"
  }
}

# MSSQL_SERVER_EXTENDED_AUDITING_POLICY MODULE REFERENCE
module "mssql_server_extended_auditing_policy" {
        source = "./Modules/mssql_server_extended_auditing_policy"

        mssql_server_extended_auditing_policy_data = var.mssql_server_extended_auditing_policy_data
}

# MSSQL_SERVER_EXTENDED_AUDITING_POLICY VARIABLE
variable "mssql_server_extended_auditing_policy_data" {
  type = map(object({
    enabled                                 = bool
    server_id                               = string
    storage_account_access_key              = string
    retention_in_days                       = number
    storage_account_subscription_id         = string
    log_monitoring_enabled                  = bool
    storage_account_access_key_is_secondary = bool
    storage_endpoint                        = string
  }))
}
