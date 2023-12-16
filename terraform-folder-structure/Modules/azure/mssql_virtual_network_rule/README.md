# MSSQL_VIRTUAL_NETWORK_RULE VALUES EXAMPLE
mssql_virtual_network_rule_data = {
  virtual_network_rule1 = {
    enabled                              = true
    name                                 = "vnet-rule-1"
    subnet_id                            = "your-subnet-id"
    server_id                            = "your-mssql-server-id"
    ignore_missing_vnet_service_endpoint = false
  }
}

# MSSQL_VIRTUAL_NETWORK_RULE MODULE REFERENCE
module "mssql_virtual_network_rule" {
        source = "./Modules/mssql_virtual_network_rule"

        mssql_virtual_network_rule_data = var.mssql_virtual_network_rule_data
}

# MSSQL_VIRTUAL_NETWORK_RULE VARIABLE
variable "mssql_virtual_network_rule_data" {
  type = map(object({
    enabled                              = bool
    name                                 = string
    subnet_id                            = string
    server_id                            = string
    ignore_missing_vnet_service_endpoint = bool
  }))
}
