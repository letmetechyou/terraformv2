# AZURE_PRIVATE_DNS_RESOLVER_FORWARDING_RULE VALUES EXAMPLE
private_dns_resolver_forwarding_rule_data = {
  rule1 = {
    enabled                  = true
    name                     = "rule-1"
    domain_name              = "example.com"
    dns_forwarding_ruleset_id = "ruleset-id-1"

    target_dns_servers = {
      ip_address = "192.168.1.1"
      port       = 53
    }

    metadata = { key1 = "value1", key2 = "value2" }
  }
  rule2 = {
    enabled                  = true
    name                     = "rule-2"
    domain_name              = "example.net"
    dns_forwarding_ruleset_name = "ruleset-name-2"

    target_dns_servers = {
      ip_address = "192.168.1.2"
    }

    metadata = { key3 = "value3", key4 = "value4" }
  }
}


# AZURE_PRIVATE_DNS_RESOLVER_FORWARDING_RULE MODULE REFERENCE
module "private_dns_resolver_forwarding_rule" {
        source = "./Modules/private_dns_resolver_forwarding_rule"

        private_dns_resolver_forwarding_rule_data = var.private_dns_resolver_forwarding_rule_data
}

# AZURE_PRIVATE_DNS_RESOLVER_FORWARDING_RULE VARIABLE
variable "private_dns_resolver_forwarding_rule_data" {
  type = map(object({
    enabled                  = bool
    name                     = string
    domain_name              = string
    dns_forwarding_ruleset_id = optional(string)
    dns_forwarding_ruleset_name = optional(string)
    dns_forwarding_ruleset_key  = optional(string)

    target_dns_servers = object({
      ip_address = string
      port       = optional(number)
    })

    metadata = map(string)
  }))
  default = {}
}
