# MSSQL_SERVER VALUES EXAMPLE
mssql_server_data = {
  server1 = {
    enabled                                 = true
    name                                    = "my-mssql-server"
    version                                 = "12.0"
    location                                = "East US"
    resource_group_name                     = "my-resource-group"
    connection_policy                       = "Proxy"
    transparent_data_encryption_key_vault_key_id = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.KeyVault/vaults/kv-1/keys/key-1"
    tags                                    = { environment = "production" }
    public_network_access_enabled           = true
    primary_user_assigned_identity_id       = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-1"
    outbound_network_restriction_enabled    = true
    minimum_tls_version                     = "1.2"
    administrator_login_password            = "StrongPassword123"
    administrator_login                     = "admin-user"

    identity = {
      type        = "SystemAssigned"
      identity_ids = []
    }

    azuread_administrator = {
      login_username               = "azuread-admin"
      object_id                    = "object-id-1"
      tenant_id                    = "tenant-id-1"
      azuread_authentication_only  = true
    }
  }
}

# MSSQL_SERVER MODULE REFERENCE
module "mssql_server" {
        source = "./Modules/mssql_server"

        mssql_server_data = var.mssql_server_data
}

# MSSQL_SERVER VARIABLE
variable "mssql_server_data" {
  type = map(object({
    enabled                                 = bool
    name                                    = string
    version                                 = string
    location                                = string
    resource_group_name                     = string
    connection_policy                       = string
    transparent_data_encryption_key_vault_key_id = string
    tags                                    = map(string)
    public_network_access_enabled           = bool
    primary_user_assigned_identity_id       = string
    outbound_network_restriction_enabled    = bool
    minimum_tls_version                     = string
    administrator_login_password            = string
    administrator_login                     = string

    identity = map(object({
      type        = string
      identity_ids = list(string)
    }))
    
    azuread_administrator = map(object({
      login_username               = string
      object_id                    = string
      tenant_id                    = string
      azuread_authentication_only  = bool
    }))
  }))
}
