# STORAGE_ACCOUNT VALUES EXAMPLE
storage_account_data = {
  storage_account1 = {
    enabled                = true
    name                   = "storageaccount1"
    account_replication_type = "LRS"
    account_tier           = "Standard"
    location               = "East US"
    resource_group_name    = "rg-1"
    tags                   = {
      environment = "production"
    }
    network_rules = {
      default_action        = "Deny"
      private_link_access    = [
        { id = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/privateLinkServices/pls-1" },
        { id = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/privateLinkServices/pls-2" }
      ]
      virtual_network_subnet_ids = [
        "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/virtualNetworks/vnet-1/subnets/subnet-1",
        "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/virtualNetworks/vnet-1/subnets/subnet-2"
      ]
      ip_rules               = ["1.2.3.4", "5.6.7.8"]
      bypass                 = ["Metrics"]
    }
    azure_files_authentication = {
      directory_type = "ActiveDirectory"
      active_directory = {
        domain_guid     = "domain-guid"
        forest_name     = "forest-name"
        domain_name     = "domain-name"
        netbios_domain_name = "netbios-domain-name"
      }
    }
    static_website = {
      index_document     = "index.html"
      error_404_document = "error.html"
    }
    queue_properties = {
      hour_metrics = {
        enabled               = true
        include_apis          = true
        retention_policy_days = 7
        version               = "1.0"
      }
      logging = {
        delete                = true
        read                  = false
        write                 = true
        retention_policy_days = 14
        version               = "1.0"
      }
      minute_metrics = {
        enabled               = true
        include_apis          = false
        retention_policy_days = 1
        version               = "1.0"
      }
      cors_rule = [
        {
          allowed_headers = ["Authorization"]
          allowed_methods = ["GET"]
          allowed_origins = ["*"]
          exposed_headers = ["*"]
          max_age_in_seconds = 3600
        }
      ]
    }
    blob_properties = {
      change_feed_retention_in_days     = 7
      delete_retention_policy = {
        days    = 30
        enabled = true
      }
      change_feed_enabled               = true
      cors_rule                         = [
        {
          allowed_headers = ["Authorization"]
          allowed_methods = ["GET"]
          allowed_origins = ["*"]
          exposed_headers = ["*"]
          max_age_in_seconds = 3600
        }
      ]
      restore_policy                    = {
        days    = 7
        enabled = true
      }
      versioning_enabled                = true
      default_service_version           = "2018-03-28"
      container_delete_retention_policy = {
        days    = 14
        enabled = true
      }
      last_access_time_enabled          = true
    }
    identity = {
      type         = "SystemAssigned"
      identity_ids = [
        "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-1"
      ]
    }
    immutability_policy = {
      period_since_creation_in_days = 30
      state                         = "Locked"
      allow_protected_append_writes = true
    }
    sas_policy = {
      expiration_period = "PT2H"
      expiration_action = "Delete"
    }
    custom_domain = {
      name          = "www.example.com"
      use_subdomain = true
    }
    share_properties = {
      smb = {
        enabled = true
        authentication_types = ["NTLMv2", "Kerberos"]
      }
      cors_rule = [
        {
          allowed_headers = ["Authorization"]
          allowed_methods = ["GET"]
          allowed_origins = ["*"]
          exposed_headers = ["*"]
          max_age_in_seconds = 3600
        }
      ]
      retention_policy = {
        days    = 30
        enabled = true
      }
    }
    routing = {
      choice                      = "MicrosoftRouting"
      publish_internet_endpoints  = false
      publish_microsoft_endpoints = true
    }
    customer_managed_key = {
      user_assigned_identity_id = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-1"
      key_vault_key_id          = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Azure.KeyVault/vaults/vault-1/keys/key-1"
    }
  }
}

# STORAGE_ACCOUNT MODULE REFERENCE
module "storage_account" {
        source = "./Modules/storage_account"

        storage_account_data = var.storage_account_data
}

# STORAGE_ACCOUNT VARIABLE
variable "storage_account_data" {
  type = map(object({
    # Required
    enabled                    = bool
    name                       = string
    account_replication_type   = string
    account_tier               = string
    location                   = string
    resource_group_name        = string

    # Optional
    queue_encryption_key_type         = optional(string)
    sftp_enabled                      = optional(bool)
    public_network_access_enabled     = optional(bool)
    table_encryption_key_type         = optional(string)
    edge_zone                         = optional(string)
    default_to_oauth_authentication   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    large_file_share_enabled          = optional(bool)
    nfsv3_enabled                     = optional(bool)
    allow_nested_items_to_be_public   = optional(bool)
    enable_https_traffic_only         = optional(bool)
    allowed_copy_scope                = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    cross_tenant_replication_enabled  = optional(bool)
    min_tls_version                   = optional(string)
    access_tier                       = optional(string)
    tags                              = optional(map(string))
    is_hns_enabled                    = optional(bool)
    account_kind                      = optional(string)

    # Optional Dynamic Blocks
    network_rules             = optional(object({
      default_action             = string
      virtual_network_subnet_ids = optional(list(string))
      ip_rules                   = optional(list(string))
      bypass                     = optional(string)
      private_link_access        = optional(list(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = string
      })))
    }))
    azure_files_authentication = optional(list(object({
      directory_type = string
      active_directory = optional(object({
        domain_name         = string
        domain_guid         = string
        storage_sid         = optional(string)
        forest_name         = optional(string)
        netbios_domain_name = optional(string)
        domain_sid          = optional(string)
      }))
    })))
    static_website            = optional(list(object({
      index_document     = string
      error_404_document = string
    })))
    queue_properties          = optional(list(object({
      hour_metrics = optional(object({
        version             = string
        enabled             = bool
        retention_policy_days = optional(number)
        include_apis        = optional(bool)
      }))
      logging = optional(object({
        write               = bool
        delete              = bool
        version             = string
        read                = bool
        retention_policy_days = optional(number)
      }))
      minute_metrics = optional(object({
        version             = string
        enabled             = bool
        retention_policy_days = optional(number)
        include_apis        = optional(bool)
      }))
      cors_rule = optional(object({
        exposed_headers    = list(string)
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        max_age_in_seconds = number
      }))
    })))
    blob_properties           = optional(list(object({
      change_feed_retention_in_days = optional(number)
      change_feed_enabled           = optional(bool)
      versioning_enabled            = optional(bool)
      default_service_version       = optional(string)
      last_access_time_enabled      = optional(bool)
      cors_rule                     = optional(object({
        exposed_headers    = list(string)
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        max_age_in_seconds = number
      }))
      delete_retention_policy       = optional(object({
        days = number
      }))
      restore_policy                = optional(object({
        days = number
      }))
      container_delete_retention_policy = optional(object({
        days = number
      }))
    })))
    identity                  = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })))
    immutability_policy        = optional(list(object({
      period_since_creation_in_days = number
      state                         = string
      allow_protected_append_writes = optional(bool)
    })))
    sas_policy                = optional(list(object({
      expiration_period = string
      expiration_action = optional(string)
    })))
    custom_domain             = optional(list(object({
      name          = string
      use_subdomain = optional(bool)
    })))
    share_properties          = optional(list(object({
      smb = optional(object({
        authentication_types            = list(string)
        channel_encryption_type         = optional(string)
        kerberos_ticket_encryption_type = optional(string)
        multichannel_enabled            = optional(bool)
        versions                        = optional(list(string))
      }))
      cors_rule                     = optional(object({
        exposed_headers    = list(string)
        allowed_origins    = list(string)
        allowed_methods    = list(string)
        allowed_headers    = list(string)
        max_age_in_seconds = number
      }))
      retention_policy              = optional(object({
        days = optional(number)
      }))
    })))
    routing                   = optional(list(object({
      choice                      = string
      publish_internet_endpoints  = optional(bool)
      publish_microsoft_endpoints = optional(bool)
    })))
    customer_managed_key      = optional(list(object({
      user_assigned_identity_id = string
      key_vault_key_id          = string
    })))
  }))
}
