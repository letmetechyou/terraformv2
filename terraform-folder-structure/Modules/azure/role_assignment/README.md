# ROLE_ASSIGNMENT VALUES EXAMPLE
role_assignment_data = {
  assignment1 = {
    enabled                           = true
    principal_id                      = "principal-id-1"
    scope                             = "/subscriptions/sub-id-1/resourceGroups/rg-1"

    role_definition_name              = "Contributor"
    condition                         = "field('tags.environment', 'equals', 'Dev')"
    description                       = "Assignment for Dev environment"
    skip_service_principal_aad_check  = false
    condition_version                 = "2.0"
    role_definition_id                = "/subscriptions/sub-id-1/providers/Microsoft.Authorization/roleDefinitions/def-id-1"
    delegated_managed_identity_resource_id = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-id-1"
    name                              = "assignment-1"
  },
  assignment2 = {
    enabled                           = true
    principal_id                      = "principal-id-2"
    scope                             = "/subscriptions/sub-id-2/resourceGroups/rg-2"

    role_definition_name              = "Reader"
    description                       = "Assignment for Reader role"
    skip_service_principal_aad_check  = true
    name                              = "assignment-2"
  },
}

# ROLE_ASSIGNMENT MODULE REFERENCE
module "role_assignment" {
        source = "./Modules/role_assignment"

        role_assignment_data = var.role_assignment_data
}

# ROLE_ASSIGNMENT VARIABLE
variable "role_assignment_data" {
  type = map(object({
    # Required
    enabled                           = bool
    principal_id                      = string
    scope                             = string

    # Optional
    role_definition_name              = optional(string)
    condition                         = optional(string)
    description                       = optional(string)
    skip_service_principal_aad_check  = optional(bool)
    condition_version                 = optional(string)
    role_definition_id                = optional(string)
    delegated_managed_identity_resource_id = optional(string)
    name                              = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}
