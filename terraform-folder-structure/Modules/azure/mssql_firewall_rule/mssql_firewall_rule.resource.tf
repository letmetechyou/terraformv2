resource "azurerm_mssql_firewall_rule" "mssql_firewall_rule" {
  for_each = { for key, value in var.mssql_firewall_rule_data : key => value if value.enabled }

  # Required Arguments
  name             = each.value.name
  server_id = coalesce(try(each.value.mssql_server_id, null), try(var.mssql_server_output["${each.value.mssql_server_name}"].id, null), try(var.mssql_server_output["${each.value.mssql_server_key}"].id, null))
  end_ip_address   = each.value.end_ip_address
  start_ip_address = each.value.start_ip_address


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
