# STORAGE_SHARE VALUES EXAMPLE
storage_share_data = {
  example_share = {
    enabled           = true
    name              = "example-share"
    quota             = 10
    storage_account_name = "your-storage-account-name"
    metadata          = {
      key1 = "value1"
      key2 = "value2"
    }
    access_tier       = "Hot"
    enabled_protocol  = "SMB"
    acl = [
      {
        id = "1"
        access_policy = {
          permissions = "rwdl"
          start       = "2023-01-01"
          expiry      = "2024-01-01"
        }
      },
      {
        id = "2"
        access_policy = {
          permissions = "r--"
        }
      }
    ]
  }
}

# STORAGE_SHARE MODULE REFERENCE
module "storage_share" {
        source = "./Modules/storage_share"

        storage_share_data = var.storage_share_data
}

# STORAGE_SHARE VARIABLE
variable "storage_share_data" {
  type = map(object({
	# Required
    	enabled           = bool
    	name              = string
    	quota             = number
    	storage_account_name = string

	# Optional
    	metadata          = optional(map(string))
    	access_tier       = optional(string)
    	enabled_protocol  = optional(string)
    	acl               = optional(list(object({
      		id            = string
      		access_policy = optional(object({
        		permissions = string
        		start       = optional(string)
        		expiry      = optional(string)
      		}))
    	})))
  }))
  default = {}
}
