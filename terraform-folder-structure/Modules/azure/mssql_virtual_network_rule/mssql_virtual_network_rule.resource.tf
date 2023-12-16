resource "azurerm_mssql_virtual_network_rule" "mssql_virtual_network_rule" {
  for_each = { for key, value in var.mssql_virtual_network_rule_data : key => value if value.enabled }

  # Required Arguments
  name      = each.value.name
  subnet_id = each.value.subnet_id
  server_id = coalesce(try(each.value.mssql_server_id, null), try(var.mssql_server_output["${each.value.mssql_server_name}"].id, null), try(var.mssql_server_output["${each.value.mssql_server_key}"].id, null))


  # Required Blocks 



  # Optional Arguments
  ignore_missing_vnet_service_endpoint = each.value.ignore_missing_vnet_service_endpoint


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
