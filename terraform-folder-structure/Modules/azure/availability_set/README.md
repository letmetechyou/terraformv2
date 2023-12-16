# AVAILABILITY_SET VALUES EXAMPLE
availability_set_data = {
  availability_set1 = {
    enabled               = true
    resource_group_name   = "rg-1"
    name                  = "availability-set-1"
    location              = "East US"
    managed               = true
    tags                  = { environment = "Production" }
    platform_update_domain_count = 5
    platform_fault_domain_count  = 3
    proximity_placement_group_id = "proximity-group-id-1"
  },
  availability_set2 = {
    enabled               = true
    resource_group_name   = "rg-2"
    name                  = "availability-set-2"
    location              = "West US"
    managed               = false
    platform_update_domain_count = 3
    platform_fault_domain_count  = 2
  },
}

# AVAILABILITY_SET MODULE REFERENCE
module "availability_set" {
        source = "./Modules/availability_set"

        availability_set_data = var.availability_set_data
}

# AVAILABILITY_SET VARIABLE
variable "availability_set_data" {
  type = map(object({
    # Required
    enabled               = bool
    resource_group_name   = string
    name                  = string
    location              = string

    # Optional
    managed                      = optional(bool)
    tags                         = optional(map(string))
    platform_update_domain_count = optional(number)
    platform_fault_domain_count  = optional(number)
    proximity_placement_group_id = optional(string)

    # Optional Dynamic Blocks
  }))
}
