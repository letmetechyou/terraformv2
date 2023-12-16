data "azurerm_client_config" "current" {}

data "azurerm_key_vault_secret" "main" {
  for_each = { for key, value in var.mssql_server_data : key => value if value.enabled }
  name = lower(each.value.administrator_login)
  key_vault_id = each.value.existing_key_vault_id
}

resource "azurerm_mssql_server" "mssql_server" {
  for_each = { for key, value in var.mssql_server_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  version             = each.value.version
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  # Required Blocks 



  # Optional Arguments
  connection_policy                            = each.value.connection_policy
  transparent_data_encryption_key_vault_key_id = each.value.transparent_data_encryption_key_vault_key_id
  tags                                         = each.value.tags
  public_network_access_enabled                = each.value.public_network_access_enabled
  primary_user_assigned_identity_id            = each.value.primary_user_assigned_identity_id
  outbound_network_restriction_enabled         = each.value.outbound_network_restriction_enabled
  minimum_tls_version                          = each.value.minimum_tls_version
  administrator_login_password                 = data.azurerm_key_vault_secret.main[each.key].value #azurerm_key_vault_secret.main[each.key].value
  administrator_login                          = each.value.administrator_login


  # Optional Dynamic Blocks
  dynamic "identity" {

    for_each = each.value["identity"] == null ? [] : [1]

    content {
      # Required
      type = each.value.identity.type

      # Optional
      identity_ids = each.value.identity.identity_ids
    }
  }


  dynamic "azuread_administrator" {

    for_each = each.value["azuread_administrator"] == null ? [] : [1]

    content {
      # Required
      login_username = each.value.azuread_administrator.login_username
      object_id      = each.value.azuread_administrator.object_id

      # Optional
      tenant_id                   = data.azurerm_client_config.current.tenant_id
      azuread_authentication_only = each.value.azuread_administrator.azuread_authentication_only
    }
  }



  lifecycle {
    prevent_destroy = false
    ignore_changes = [ administrator_login_password ]
  }
}