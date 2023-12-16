# MANAGED_DISK VALUES EXAMPLE
managed_disk_data = {
  disk1 = {
    enabled             = true
    location            = "East US"
    resource_group_name = "rg-1"
    name                = "disk-1"
    create_option        = "Copy"
    storage_account_type = "Standard_LRS"
    disk_iops_read_write = 500
    tier                = "Standard"
    os_type             = "Linux"
    disk_size_gb        = 64
    tags = {
      environment = "Development"
    }
    encryption_settings = {
      disk_encryption_key = {
        source_vault_id = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.KeyVault/vaults/vault-1"
        secret_url      = "https://vault-1.vault.azure.net/secrets/secret-1"
      }
    }
  },
  disk2 = {
    enabled             = true
    location            = "West US"
    resource_group_name = "rg-2"
    name                = "disk-2"
    create_option        = "Empty"
    storage_account_type = "Premium_LRS"
  },
}

# MANAGED_DISK MODULE REFERENCE
module "managed_disk" {
        source = "./Modules/managed_disk"

        managed_disk_data = var.managed_disk_data
}

# MANAGED_DISK VARIABLE
variable "managed_disk_data" {
  type = map(object({
    # Required
    enabled             = bool
    location            = string
    resource_group_name = string
    name                = string
    create_option        = string
    storage_account_type = string

    # Optional
    storage_account_id                = optional(string)
    network_access_policy             = optional(string)
    disk_iops_read_write              = optional(number)
    disk_mbps_read_only               = optional(number)
    disk_iops_read_only               = optional(number)
    tier                              = optional(string)
    secure_vm_disk_encryption_set_id  = optional(string)
    security_type                     = optional(string)
    optimized_frequent_attach_enabled = optional(bool)
    os_type                           = optional(string)
    disk_size_gb                      = optional(number)
    source_resource_id                = optional(string)
    disk_encryption_set_id            = optional(string)
    hyper_v_generation                = optional(string)
    disk_access_id                    = optional(string)
    upload_size_bytes                 = optional(number)
    tags                              = optional(map(string))
    trusted_launch_enabled            = optional(bool)
    max_shares                        = optional(number)
    on_demand_bursting_enabled        = optional(bool)
    image_reference_id                = optional(string)
    logical_sector_size               = optional(number)
    zone                              = optional(string)
    public_network_access_enabled     = optional(string)
    gallery_image_reference_id        = optional(string)
    source_uri                        = optional(string)
    performance_plus_enabled          = optional(bool)
    disk_mbps_read_write              = optional(number)
    edge_zone                         = optional(string)

    encryption_settings = optional(object({
      disk_encryption_key  = optional(object({
        source_vault_id = string
        secret_url      = string
      }))
      key_encryption_key  = optional(object({
        source_vault_id = string
        key_url         = string
      }))
    }))

    # Optional Dynamic Blocks
  }))
  default = {}
}
