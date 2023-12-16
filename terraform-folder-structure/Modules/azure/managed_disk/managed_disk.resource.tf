resource "azurerm_managed_disk" "managed_disk" {
  for_each = { for key, value in var.managed_disk_data : key => value if value.enabled }

  # Required Arguments
  location             = each.value.location
  resource_group_name  = each.value.resource_group_name
  name                 = each.value.name
  create_option        = each.value.create_option
  storage_account_type = each.value.storage_account_type


  # Required Blocks 



  # Optional Arguments
  storage_account_id                = each.value.storage_account_id
  network_access_policy             = each.value.network_access_policy
  disk_iops_read_write              = each.value.disk_iops_read_write
  disk_mbps_read_only               = each.value.disk_mbps_read_only
  disk_iops_read_only               = each.value.disk_iops_read_only
  tier                              = each.value.tier
  secure_vm_disk_encryption_set_id  = each.value.secure_vm_disk_encryption_set_id
  security_type                     = each.value.security_type
  optimized_frequent_attach_enabled = each.value.optimized_frequent_attach_enabled
  os_type                           = each.value.os_type
  disk_size_gb                      = each.value.disk_size_gb
  source_resource_id                = each.value.source_resource_id
  disk_encryption_set_id            = each.value.disk_encryption_set_id
  hyper_v_generation                = each.value.hyper_v_generation
  disk_access_id                    = each.value.disk_access_id
  upload_size_bytes                 = each.value.upload_size_bytes
  tags                              = each.value.tags
  trusted_launch_enabled            = each.value.trusted_launch_enabled
  max_shares                        = each.value.max_shares
  on_demand_bursting_enabled        = each.value.on_demand_bursting_enabled
  image_reference_id                = each.value.image_reference_id
  logical_sector_size               = each.value.logical_sector_size
  zone                              = each.value.zone
  public_network_access_enabled     = each.value.public_network_access_enabled
  gallery_image_reference_id        = each.value.gallery_image_reference_id
  source_uri                        = each.value.source_uri
  performance_plus_enabled          = each.value.performance_plus_enabled
  disk_mbps_read_write              = each.value.disk_mbps_read_write
  edge_zone                         = each.value.edge_zone


  # Optional Dynamic Blocks
  dynamic "encryption_settings" {

    for_each = each.value.encryption_settings != null ? [1] : []

    content {
      # Required

      # Optional
      #disk_encryption_key = each.value.encryption_settings.disk_encryption_key
	dynamic "disk_encryption_key" {

		for_each = each.value.encryption_settings.disk_encryption_key != null ? [1] : []

		content {
		# Required
		source_vault_id = each.value.encryption_settings.disk_encryption_key.source_vault_id
		secret_url      = each.value.encryption_settings.disk_encryption_key.secret_url

		# Optional
		}
	}
      
      #key_encryption_key  = each.value.encryption_settings.key_encryption_key
	dynamic "key_encryption_key" {

		for_each = each.value.encryption_settings.key_encryption_key != null ? [1] : []

		content {
		# Required
		source_vault_id = each.value.encryption_settings.key_encryption_key.source_vault_id
		key_url         = each.value.encryption_settings.key_encryption_key.key_url

		# Optional
		}
	}
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
