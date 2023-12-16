data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "main" {
for_each = { for key, value in var.key_vault_access_policy_data : key => value if value.enabled }  
key_vault_id = each.value.existing_key_vault_id
tenant_id = data.azurerm_client_config.current.tenant_id
object_id = each.value.obj_id #coalesce(each.value.obj_id, each.value.group_id, each.value.service_principal_id)
secret_permissions = each.value.secret_permissions
certificate_permissions = each.value.certificate_permissions
key_permissions = each.value.key_permissions
storage_permissions = each.value.storage_permissions

}