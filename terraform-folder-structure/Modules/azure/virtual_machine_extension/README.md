# VIRTUAL_MACHINE_EXTENSION VALUES EXAMPLE
virtual_machine_extension_data = {
  extension1 = {
    enabled               = true
    type_handler_version = "2.0"
    type                 = "CustomScript"
    publisher            = "Microsoft.Compute"
    virtual_machine_name = "vm-1"
    name                 = "extension-1"
    protected_settings_from_key_vault = [
      {
        source_vault_id = "vault-id-1"
        secret_url      = "https://vault-uri-1/secrets/secret-name-1"
      },
    ]
  },
  extension2 = {
    enabled               = true
    type_handler_version = "1.9"
    type                 = "DSC"
    publisher            = "Microsoft.Compute"
    virtual_machine_key  = "vm-key-2"
    name                 = "extension-2"
    protected_settings_from_key_vault = [
      {
        source_vault_id = "vault-id-2"
        secret_url      = "https://vault-uri-2/secrets/secret-name-2"
      },
    ]
  },
}

# VIRTUAL_MACHINE_EXTENSION MODULE REFERENCE
module "virtual_machine_extension" {
        source = "./Modules/virtual_machine_extension"

        virtual_machine_extension_data = var.virtual_machine_extension_data
}

# VIRTUAL_MACHINE_EXTENSION VARIABLE
variable "virtual_machine_extension_data" {
  type = map(object({
    # Required
    enabled               = bool
    type_handler_version = string
    type                 = string
    publisher            = string
    virtual_machine_name = optional(string)
    virtual_machine_key  = optional(string)
    name                 = string

    # Optional

    # Optional Dynamic Blocks
    protected_settings_from_key_vault = optional(list(object({
      # Required
      source_vault_id = string
      secret_url      = string

      # Optional
    })))
  }))
}
