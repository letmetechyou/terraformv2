# MANAGEMENT_LOCK VALUES EXAMPLE
management_lock_data = {
  lock1 = {
    enabled   = true
    lock_level = "CanNotDelete"
    scope      = "/subscriptions/sub-id-1/resourceGroups/rg-1"
    name       = "lock-1"
    notes     = "This lock prevents resource deletion."
  },
  lock2 = {
    enabled   = true
    lock_level = "ReadOnly"
    scope      = "/subscriptions/sub-id-2/resourceGroups/rg-2"
    name       = "lock-2"
  },
}

# MANAGEMENT_LOCK MODULE REFERENCE
module "management_lock" {
        source = "./Modules/management_lock"

        management_lock_data = var.management_lock_data
}

# MANAGEMENT_LOCK VARIABLE
variable "management_lock_data" {
  type = map(object({
    # Required
    enabled   = bool
    lock_level = string
    scope      = optional(string)
    name       = optional(string)
    key        = optional(string)

    # Optional
    notes     = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}
