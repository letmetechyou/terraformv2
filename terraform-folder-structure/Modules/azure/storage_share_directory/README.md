# STORAGE_SHARE_DIRECTORY VALUES EXAMPLE
storage_share_directory_data = {
  directory1 = {
    enabled              = true
    name                 = "example-directory"
    share_name           = "example-share"
    storage_account_name = "mystorageaccount"
    metadata             = {
      environment = "production"
      team        = "devops"
    }
  }

  directory2 = {
    enabled              = true
    name                 = "another-directory"
    share_name           = "another-share"
    storage_account_name = "anotherstorageaccount"
    metadata             = {
      environment = "staging"
      team        = "engineering"
    }
  }
}

# STORAGE_SHARE_DIRECTORY MODULE REFERENCE
module "storage_share_directory" {
        source = "./Modules/storage_share_directory"

        storage_share_directory_data = var.storage_share_directory_data
}

# STORAGE_SHARE_DIRECTORY VARIABLE
variable "storage_share_directory_data" {
  type = map(object({
    enabled              = bool
    name                 = string
    share_name           = string
    storage_account_name = string
    metadata             = optional(map(string))
  }))
  default = {}
}
