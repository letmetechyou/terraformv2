resource "azurerm_role_assignment" "role_assignment" {
  for_each = { for key, value in var.role_assignment_data : key => value if value.enabled }

  # Required Arguments
  principal_id = each.value.principal_id
  scope        = each.value.scope


  # Required Blocks 



  # Optional Arguments
  role_definition_name                   = each.value.role_definition_name
  condition                              = each.value.condition
  description                            = each.value.description
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
  condition_version                      = each.value.condition_version
  role_definition_id                     = each.value.role_definition_id
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  name                                   = each.value.name


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
