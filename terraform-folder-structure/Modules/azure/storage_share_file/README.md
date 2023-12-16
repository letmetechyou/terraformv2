# STORAGE_SHARE_FILE VALUES EXAMPLE
storage_share_file_data = {
  file1 = {
    enabled             = true
    storage_share_id    = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.Storage/storageAccounts/storage-account-1/fileServices/default/shares/share-1"
    name                = "file-1"
    content_type        = "text/plain"
    path                = "/path/to/file-1.txt"
    content_md5         = "md5-hash-1"
    metadata            = {
      key1 = "value1"
      key2 = "value2"
    }
    content_disposition = "attachment"
    source              = "/path/to/source/file-1.txt"
    content_encoding    = "gzip"
  },
  file2 = {
    enabled             = true
    storage_share_id    = "/subscriptions/sub-id-2/resourceGroups/rg-2/providers/Microsoft.Storage/storageAccounts/storage-account-2/fileServices/default/shares/share-2"
    name                = "file-2"
    content_type        = "application/json"
    path                = "/path/to/file-2.json"
    content_md5         = "md5-hash-2"
    metadata            = {
      key3 = "value3"
      key4 = "value4"
    }
    content_disposition = "inline"
    source              = "/path/to/source/file-2.json"
    content_encoding    = "identity"
  },
}

# STORAGE_SHARE_FILE MODULE REFERENCE
module "storage_share_file" {
        source = "./Modules/storage_share_file"

        storage_share_file_data = var.storage_share_file_data
}

# STORAGE_SHARE_FILE VARIABLE
variable "storage_share_file_data" {
  type = map(object({
    # Required
    enabled        = bool
    storage_share_id = string
    name           = string

    # Optional
    content_type        = optional(string)
    path                = optional(string)
    content_md5         = optional(string)
    metadata            = optional(map(string))
    content_disposition = optional(string)
    source              = optional(string)
    content_encoding    = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}
