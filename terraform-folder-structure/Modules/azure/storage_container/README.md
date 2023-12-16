# STORAGE_CONTAINER VALUES EXAMPLE
storage_container_data = {
  container1 = {
    enabled             = true
    storage_account_name = "storage-account-1"
    name                = "container-1"
    container_access_type = "private"
    metadata = {
      key1 = "value1"
      key2 = "value2"
    }
  },
  container2 = {
    enabled             = true
    storage_account_name = "storage-account-2"
    name                = "container-2"
    container_access_type = "blob"
  },
}

# STORAGE_CONTAINER MODULE REFERENCE
module "storage_container" {
        source = "./Modules/storage_container"

        storage_container_data = var.storage_container_data
}

# STORAGE_CONTAINER VARIABLE
variable "storage_container_data" {
  type = map(object({
    # Required
    enabled             = bool
    storage_account_name = string
    name                = string

    # Optional
    container_access_type = optional(string)
    metadata              = optional(map(string))

    # Optional Dynamic Blocks
  }))
}
