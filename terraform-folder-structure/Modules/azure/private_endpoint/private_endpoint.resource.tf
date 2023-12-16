resource "azurerm_private_endpoint" "private_endpoint" {
    for_each = { for key, value in var.private_endpoint_data : key => value if value.enabled }
     name = lower("${each.value.name}-pep")
     resource_group_name = each.value.resource_group_name
     location = each.value.location
     subnet_id = each.value.subnet_id
     custom_network_interface_name = lower("${each.value.name}-nic")
    
    private_service_connection {
        name = each.value.private_service_connection.name
        is_manual_connection = each.value.private_service_connection.is_manual_connection
        private_connection_resource_id = coalesce(try(var.mssql_server_output["${each.value.private_service_connection.private_connection_resource_id}"].id, null), 
        try(var.storage_account_output["${each.value.private_service_connection.private_connection_resource_id}"].id, null),
        try(var.key_vault_output["${each.value.private_service_connection.private_connection_resource_id}"].id, null),
        try(each.value.private_service_connection.private_connection_resource_id, null)
        )
        subresource_names = each.value.private_service_connection.subresource_names
    }

    dynamic "private_dns_zone_group" {
      for_each = each.value["private_dns_zone_group"] == null ? [] : [1]
      content {
        name = each.value.private_dns_zone_group.name
        private_dns_zone_ids =  each.value.private_dns_zone_group.private_dns_zone_ids
      }
    }
}