# SSH_PUBLIC_KEY VALUES EXAMPLE
ssh_public_key_data = {
  ssh_key1 = {
    enabled            = true
    resource_group_name = "rg-1"
    location            = "East US"
    name                = "ssh-key-1"
    public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDaa6qW4..."

    tags = {
      environment = "dev"
    }
  },
  ssh_key2 = {
    enabled            = true
    resource_group_name = "rg-2"
    location            = "West US"
    name                = "ssh-key-2"
    public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLk5YjG8..."

    tags = {
      environment = "prod"
    }
  }
}

# SSH_PUBLIC_KEY MODULE REFERENCE
module "ssh_public_key" {
        source = "./Modules/ssh_public_key"

        ssh_public_key_data = var.ssh_public_key_data
}

# SSH_PUBLIC_KEY VARIABLE
variable "ssh_public_key_data" {
  type = map(object({
    # Required
    enabled            = bool
    resource_group_name = string
    location            = string
    name                = string
    public_key          = string

    # Optional
    tags = optional(map(string))
  }))
  default = {}
}
