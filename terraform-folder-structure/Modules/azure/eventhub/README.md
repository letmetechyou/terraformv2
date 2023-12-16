# EVENTHUB VALUES EXAMPLE
eventhub_data = {
  eventhub1 = {
    enabled            = true
    namespace_name      = "namespace-1"
    message_retention   = 7
    resource_group_name = "rg-1"
    name                = "eventhub-1"
    partition_count     = 4
    status              = "Active"
    capture_description = {
      destination = {
        archive_name_format = "{DateTime}-{Guid}.avro"
        blob_container_name = "capture-container"
        name                = "capture"
        storage_account_id  = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.Storage/storageAccounts/storage-account-1"
      }
      enabled            = true
      encoding           = "Avro"
      skip_empty_archives = true
      size_limit_in_bytes = 1048576
      interval_in_seconds = 300
    }
  },
  eventhub2 = {
    enabled            = true
    namespace_name      = "namespace-2"
    message_retention   = 7
    resource_group_name = "rg-2"
    name                = "eventhub-2"
    partition_count     = 8
  },
}

# EVENTHUB MODULE REFERENCE
module "eventhub" {
        source = "./Modules/eventhub"

        eventhub_data = var.eventhub_data
}

# EVENTHUB VARIABLE
variable "eventhub_data" {
  type = map(object({
    # Required
    enabled            = bool
    namespace_name      = string
    message_retention   = number
    resource_group_name = string
    name                = string
    partition_count     = number

    # Optional
    status = optional(string)

    # Optional Dynamic Blocks
    capture_description = optional(object({
      # Required
      destination = object({
        # Required
        archive_name_format = string
        blob_container_name = string
        name                = string
        storage_account_id  = string
        # Optional
      })
      enabled            = bool
      encoding           = string

      # Optional
      skip_empty_archives = bool
      size_limit_in_bytes = number
      interval_in_seconds = number
    }))
  }))
  default = {}
}
