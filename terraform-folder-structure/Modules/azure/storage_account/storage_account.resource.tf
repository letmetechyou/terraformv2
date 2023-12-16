resource "azurerm_storage_account" "main" {
  for_each = { for key, value in var.storage_account_data : key => value if value.enabled }

  # Required Arguments
  name                     = each.value.name
  account_replication_type = each.value.account_replication_type
  account_tier             = each.value.account_tier
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name


  # Required Blocks 



  # Optional Arguments
  queue_encryption_key_type         = each.value.queue_encryption_key_type
  sftp_enabled                      = each.value.sftp_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  table_encryption_key_type         = each.value.table_encryption_key_type
  edge_zone                         = each.value.edge_zone
  default_to_oauth_authentication   = each.value.default_to_oauth_authentication
  shared_access_key_enabled         = each.value.shared_access_key_enabled
  large_file_share_enabled          = each.value.large_file_share_enabled
  nfsv3_enabled                     = each.value.nfsv3_enabled
  allow_nested_items_to_be_public   = each.value.allow_nested_items_to_be_public
  enable_https_traffic_only         = each.value.enable_https_traffic_only
  allowed_copy_scope                = each.value.allowed_copy_scope
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  cross_tenant_replication_enabled  = each.value.cross_tenant_replication_enabled
  min_tls_version                   = each.value.min_tls_version
  access_tier                       = each.value.access_tier
  tags                              = each.value.tags
  is_hns_enabled                    = each.value.is_hns_enabled
  account_kind                      = each.value.account_kind


  # Optional Dynamic Blocks
  dynamic "network_rules" {

    for_each = each.value.network_rules != null ? [1] : []

    content {
      # Required
      default_action = each.value.network_rules.default_action

      # Optional
      virtual_network_subnet_ids = each.value.network_rules.virtual_network_subnet_ids
      ip_rules                   = each.value.network_rules.ip_rules
      bypass                     = each.value.network_rules.bypass

      # Optional Dynamic Blocks
      dynamic "private_link_access" {
        for_each = each.value.network_rules.private_link_access != null ? range(length(each.value.network_rules.private_link_access)) : []

        content {
          endpoint_resource_id = each.value.network_rules.private_link_access[private_link_access.key].endpoint_resource_id
          endpoint_tenant_id   = each.value.network_rules.private_link_access[private_link_access.key].endpoint_tenant_id
        }
      }
    }
  }

  dynamic "azure_files_authentication" {

    for_each = each.value.azure_files_authentication != null ? range(length(each.value.azure_files_authentication)) : []

    content {
      # Required
      directory_type = each.value.azure_files_authentication[azure_files_authentication.key].directory_type

      # Optional

      # Optional Dynamic Blocks
      dynamic "active_directory" {

        for_each = each.value.azure_files_authentication[azure_files_authentication.key].active_directory != null ? [1] : []

        content {
          # Required
          domain_name = each.value.azure_files_authentication[azure_files_authentication.key].active_directory.domain_name
          domain_guid = each.value.azure_files_authentication[azure_files_authentication.key].active_directory.domain_guid

          # Optional
          storage_sid         = each.value.azure_files_authentication[azure_files_authentication.key].active_directory.storage_sid
          forest_name         = each.value.azure_files_authentication[azure_files_authentication.key].active_directory.forest_name
          netbios_domain_name = each.value.azure_files_authentication[azure_files_authentication.key].active_directory.netbios_domain_name
          domain_sid          = each.value.azure_files_authentication[azure_files_authentication.key].active_directory.domain_sid
        }
      }
    }
  }

  dynamic "static_website" {

    for_each = each.value.static_website != null ? range(length(each.value.static_website)) : []

    content {
      # Required

      # Optional
      index_document     = each.value.static_website[static_website.key].index_document
      error_404_document = each.value.static_website[static_website.key].error_404_document
    }
  }

  dynamic "queue_properties" {

    for_each = each.value.queue_properties != null ? range(length(each.value.queue_properties)) : []

    content {
      # Required

      # Optional

      # Optional Dynamic Blocks
      dynamic "hour_metrics" {

        for_each = each.value.queue_properties[queue_properties.key].hour_metrics != null ? [1] : []

        content {
          # Required
          version = each.value.queue_properties[queue_properties.key].hour_metrics.version
          enabled = each.value.queue_properties[queue_properties.key].hour_metrics.enabled

          # Optional
          retention_policy_days = each.value.queue_properties[queue_properties.key].hour_metrics.retention_policy_days
          include_apis          = each.value.queue_properties[queue_properties.key].hour_metrics.include_apis
        }
      }

      dynamic "logging" {

        for_each = each.value.queue_properties[queue_properties.key].logging != null ? [1] : []

        content {
          # Required
          write   = each.value.queue_properties[queue_properties.key].logging.write
          delete  = each.value.queue_properties[queue_properties.key].logging.delete
          version = each.value.queue_properties[queue_properties.key].logging.version
          read    = each.value.queue_properties[queue_properties.key].logging.read

          # Optional
          retention_policy_days = each.value.queue_properties[queue_properties.key].logging.retention_policy_days
        }
      }

      dynamic "minute_metrics" {

        for_each = each.value.queue_properties[queue_properties.key].minute_metrics != null ? [1] : []

        content {
          # Required
          version = each.value.queue_properties[queue_properties.key].minute_metrics.version
          enabled = each.value.queue_properties[queue_properties.key].minute_metrics.enabled

          # Optional
          retention_policy_days = each.value.queue_properties[queue_properties.key].minute_metrics.retention_policy_days
          include_apis          = each.value.queue_properties[queue_properties.key].minute_metrics.include_apis
        }
      }

      dynamic "cors_rule" {

        for_each = each.value.queue_properties[queue_properties.key].cors_rule != null ? [1] : []

        content {
          # Required
          exposed_headers    = each.value.queue_properties[queue_properties.key].cors_rule.exposed_headers
          allowed_origins    = each.value.queue_properties[queue_properties.key].cors_rule.allowed_origins
          allowed_methods    = each.value.queue_properties[queue_properties.key].cors_rule.allowed_methods
          allowed_headers    = each.value.queue_properties[queue_properties.key].cors_rule.allowed_headers
          max_age_in_seconds = each.value.queue_properties[queue_properties.key].cors_rule.max_age_in_seconds

          # Optional
        }
      }
    }
  }

  dynamic "blob_properties" {

    #for_each = each.value.blob_properties != null ? range(length(each.value.blob_properties)) : []
    for_each = each.value.blob_properties != null ? [1] : []

    content {
      # Required

      # Optional
      change_feed_retention_in_days = each.value.blob_properties.change_feed_retention_in_days
      change_feed_enabled           = each.value.blob_properties.change_feed_enabled
      versioning_enabled            = each.value.blob_properties.versioning_enabled
      default_service_version       = each.value.blob_properties.default_service_version
      last_access_time_enabled      = each.value.blob_properties.last_access_time_enabled

      # Optional Dynamic Blocks
      #cors_rule                         = each.value.blob_properties.cors_rule
      dynamic "cors_rule" {
        for_each = each.value.blob_properties.cors_rule != null ? [1] : []

        content {
          # Required
          exposed_headers    = each.value.blob_properties.cors_rule.exposed_headers
          allowed_origins    = each.value.blob_properties.cors_rule.allowed_origins
          allowed_methods    = each.value.blob_properties.cors_rule.allowed_methods
          allowed_headers    = each.value.blob_properties.cors_rule.allowed_headers
          max_age_in_seconds = each.value.blob_properties.cors_rule.max_age_in_seconds

          # Optional
        }
      }
      #delete_retention_policy           = each.value.blob_properties.delete_retention_policy
      dynamic "delete_retention_policy" {

        for_each = each.value.blob_properties.delete_retention_policy != null ? [1] : []


        content {
          # Required

          # Optional
          days = each.value.blob_properties.delete_retention_policy.days
        }
      }


      #restore_policy                    = each.value.blob_properties.restore_policy
      dynamic "restore_policy" {

        for_each = each.value.blob_properties.restore_policy != null ? [1] : []
        content {
          # Required
          days = each.value.blob_properties.restore_policy.days

          # Optional
        }
      }

      #container_delete_retention_policy = each.value.blob_properties.container_delete_retention_policy
      dynamic "container_delete_retention_policy" {

        for_each = each.value.blob_properties.container_delete_retention_policy != null ? [1] : []

        content {
          # Required

          # Optional
          days = each.value.blob_properties.container_delete_retention_policy.days
        }
      }

    }
  }

  dynamic "identity" {

    for_each = each.value.identity != null ? range(length(each.value.identity)) : []

    content {
      # Required
      type = each.value.identity[identity.key].type

      # Optional
      identity_ids = each.value.identity[identity.key].identity_ids
    }
  }

  dynamic "immutability_policy" {

    for_each = each.value.immutability_policy != null ? range(length(each.value.immutability_policy)) : []

    content {
      # Required
      period_since_creation_in_days = each.value.immutability_policy[immutability_policy.key].period_since_creation_in_days
      state                         = each.value.immutability_policy[immutability_policy.key].state
      allow_protected_append_writes = each.value.immutability_policy[immutability_policy.key].allow_protected_append_writes

      # Optional
    }
  }

  dynamic "sas_policy" {

    for_each = each.value.sas_policy != null ? range(length(each.value.sas_policy)) : []

    content {
      # Required
      expiration_period = each.value.sas_policy[sas_policy.key].expiration_period

      # Optional
      expiration_action = each.value.sas_policy[sas_policy.key].expiration_action
    }
  }

  dynamic "custom_domain" {

    for_each = each.value.custom_domain != null ? range(length(each.value.custom_domain)) : []

    content {
      # Required
      name = each.value.custom_domain[custom_domain.key].name

      # Optional
      use_subdomain = each.value.custom_domain[custom_domain.key].use_subdomain
    }
  }

  dynamic "share_properties" {

    for_each = each.value.share_properties != null ? range(length(each.value.share_properties)) : []

    content {
      # Required

      # Optional

      # Optional Dynamic Blocks

      dynamic "smb" {

        for_each = each.value.share_properties[share_properties.key].smb != null ? [1] : []

        content {
          # Required

          # Optional
          authentication_types            = each.value.share_properties[share_properties.key].smb.authentication_types
          channel_encryption_type         = each.value.share_properties[share_properties.key].smb.channel_encryption_type
          kerberos_ticket_encryption_type = each.value.share_properties[share_properties.key].smb.kerberos_ticket_encryption_type
          multichannel_enabled            = each.value.share_properties[share_properties.key].smb.multichannel_enabled
          versions                        = each.value.share_properties[share_properties.key].smb.versions
        }
      }

      dynamic "cors_rule" {

        for_each = each.value.share_properties[share_properties.key].cors_rule != null ? [1] : []

        content {
          # Required
          exposed_headers    = each.value.share_properties[share_properties.key].cors_rule.exposed_headers
          allowed_origins    = each.value.share_properties[share_properties.key].cors_rule.allowed_origins
          allowed_methods    = each.value.share_properties[share_properties.key].cors_rule.allowed_methods
          allowed_headers    = each.value.share_properties[share_properties.key].cors_rule.allowed_headers
          max_age_in_seconds = each.value.share_properties[share_properties.key].cors_rule.max_age_in_seconds

          # Optional
        }
      }

      dynamic "retention_policy" {

        for_each = each.value.share_properties[share_properties.key].retention_policy != null ? [1] : []

        content {
          # Required

          # Optional
          days = each.value.share_properties[share_properties.key].retention_policy.days
        }
      }



    }
  }

  dynamic "routing" {

    for_each = each.value.routing != null ? range(length(each.value.routing)) : []

    content {
      # Required

      # Optional
      choice                      = each.value.routing[routing.key].choice
      publish_internet_endpoints  = each.value.routing[routing.key].publish_internet_endpoints
      publish_microsoft_endpoints = each.value.routing[routing.key].publish_microsoft_endpoints
    }
  }

  dynamic "customer_managed_key" {

    for_each = each.value.customer_managed_key != null ? range(length(each.value.customer_managed_key)) : []

    content {
      # Required
      user_assigned_identity_id = each.value.customer_managed_key[customer_managed_key.key].user_assigned_identity_id
      key_vault_key_id          = each.value.customer_managed_key[customer_managed_key.key].key_vault_key_id

      # Optional
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
