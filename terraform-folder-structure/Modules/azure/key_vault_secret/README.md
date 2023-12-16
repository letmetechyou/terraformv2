# KEY_VAULT_SECRET VALUES EXAMPLE
key_vault_secret_data = {
  secret1 = {
    enabled         = true
    name            = "my-secret-1"
    value           = "your-secret-value-1"
    key_vault_id    = "your-key-vault-id"
    tags            = { "environment" = "production" }
    content_type    = "text/plain"
    not_before_date = "2023-01-01T00:00:00Z"
    expiration_date = "2023-12-31T23:59:59Z"
  }

  secret2 = {
    enabled         = true
    name            = "my-secret-2"
    value           = "your-secret-value-2"
    key_vault_id    = "your-key-vault-id"
    tags            = { "environment" = "development" }
    content_type    = "application/json"
    not_before_date = "2023-01-01T00:00:00Z"
    expiration_date = "2023-12-31T23:59:59Z"
  }
}

# KEY_VAULT_SECRET MODULE REFERENCE
module "key_vault_secret" {
        source = "./Modules/key_vault_secret"

        key_vault_secret_data = var.key_vault_secret_data
}

# KEY_VAULT_SECRET VARIABLE
variable "key_vault_secret_data" {
  type = map(object({
    enabled         = bool
    name            = string
    value           = string
    key_vault_id    = string
    tags            = map(string)
    content_type    = string
    not_before_date = string
    expiration_date = string
  }))
}
