# MSSQL_SERVER_SECURITY_ALERT_POLICY VALUES EXAMPLE
mssql_server_security_alert_policy_data = {
  alert_policy1 = {
    enabled                    = true
    resource_group_name        = "your-resource-group"
    state                      = "Enabled"
    server_name                = "your-sql-server"
    email_addresses            = ["admin1@example.com", "admin2@example.com"]
    email_account_admins       = true
    storage_account_access_key = "your-storage-account-access-key"
    retention_days             = 30
    storage_endpoint           = "https://your-storage-account.blob.core.windows.net/"
    disabled_alerts            = ["Sql_Injection", "SQL_Authentication_Brute_Force"]
  }
}

# MSSQL_SERVER_SECURITY_ALERT_POLICY MODULE REFERENCE
module "mssql_server_security_alert_policy" {
        source = "./Modules/mssql_server_security_alert_policy"

        mssql_server_security_alert_policy_data = var.mssql_server_security_alert_policy_data
}

# MSSQL_SERVER_SECURITY_ALERT_POLICY VARIABLE
variable "mssql_server_security_alert_policy_data" {
  type = map(object({
    enabled                    = bool
    resource_group_name        = string
    state                      = string
    server_name                = string
    email_addresses            = list(string)
    email_account_admins       = bool
    storage_account_access_key = string
    retention_days             = number
    storage_endpoint           = string
    disabled_alerts            = list(string)
  }))
}
