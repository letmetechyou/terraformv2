# MSSQL_FIREWALL_RULE VALUES EXAMPLE
mssql_firewall_rule_data = {
  rule1 = {
    enabled          = true
    name             = "firewall-rule-1"
    server_id        = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Sql/servers/sql-server-1"
    end_ip_address   = "192.168.1.10"
    start_ip_address = "192.168.1.1"
  }
  rule2 = {
    enabled          = true
    name             = "firewall-rule-2"
    server_id        = "/subscriptions/subscription-id/resourceGroups/rg-2/providers/Microsoft.Sql/servers/sql-server-2"
    end_ip_address   = "192.168.2.10"
    start_ip_address = "192.168.2.1"
  }
}

# MSSQL_FIREWALL_RULE MODULE REFERENCE
module "mssql_firewall_rule" {
        source = "./Modules/mssql_firewall_rule"

        mssql_firewall_rule_data = var.mssql_firewall_rule_data
}

# MSSQL_FIREWALL_RULE VARIABLE
variable "mssql_firewall_rule_data" {
  type = map(object({
    # Required
    enabled          = bool
    name             = string
    server_id        = string
    end_ip_address   = string
    start_ip_address = string

    # Optional
  }))
}
