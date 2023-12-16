# VIRTUAL_MACHINE_DATA_DISK_ATTACHMENT VALUES EXAMPLE
virtual_machine_data_disk_attachment_data = {
  attachment1 = {
    enabled            = true
    lun                = 0
    virtual_machine_id = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.Compute/virtualMachines/vm-1"
    caching            = "None"
  },
  attachment2 = {
    enabled            = true
    lun                = 1
    managed_disk_id    = "/subscriptions/sub-id-2/resourceGroups/rg-2/providers/Microsoft.Compute/disks/disk-1"
    create_option      = "Attach"
    caching            = "ReadOnly"
    write_accelerator_enabled = true
  },
}

# VIRTUAL_MACHINE_DATA_DISK_ATTACHMENT MODULE REFERENCE
module "virtual_machine_data_disk_attachment" {
        source = "./Modules/virtual_machine_data_disk_attachment"

        virtual_machine_data_disk_attachment_data = var.virtual_machine_data_disk_attachment_data
}

# VIRTUAL_MACHINE_DATA_DISK_ATTACHMENT VARIABLE
variable "virtual_machine_data_disk_attachment_data" {
  type = map(object({
    # Required
    enabled            = bool
    managed_disk_id    = optional(string)
    managed_disk_name  = optional(string)
    managed_disk_key   = optional(string)
    lun                = number
    virtual_machine_id = optional(string)
    virtual_machine_name = optional(string)
    virtual_machine_key = optional(string)
    caching            = string

    # Optional
    create_option             = optional(string)
    write_accelerator_enabled = optional(bool)

    # Optional Dynamic Blocks
  }))
  default = {}
}
