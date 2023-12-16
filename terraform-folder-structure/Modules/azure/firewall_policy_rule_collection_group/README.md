# AZURE_FIREWALL_POLICY_RULE_COLLECTION_GROUP VALUES EXAMPLE
variable "firewall_policy_rule_collection_group_data" {
  firewall_policy_rule_collection_group_data = [
    {
      "group1" = {
        name               = "MyRuleCollectionGroup1"
        firewall_policy_id = "MyFirewallPolicyID1"
        priority           = 1000

        application_rule_collection = [
          {
            name    = "AppRuleCollection1"
            action  = "Allow"
            priority = 100

            rule = [
              {
                name            = "AppRule1"
                description     = "Allow HTTP"
                protocols       = ["Http"]
                source_addresses = ["10.0.0.0/24"]
                destination_urls = ["example.com"]
              },
            ]
          },
        ]

        nat_rule_collection = [
          {
            name    = "NatRuleCollection1"
            action  = "Dnat"
            priority = 200

            rule = [
              {
                name              = "NatRule1"
                protocols         = ["TCP"]
                source_addresses  = ["10.0.0.0/24"]
                destination_ports = ["80"]
                translated_address = "192.168.1.10"
                translated_port    = 8080
              },
            ]
          },
        ]

        network_rule_collection = [
          {
            name    = "NetRuleCollection1"
            action  = "Allow"
            priority = 300

            rule = [
              {
                name                  = "NetRule1"
                protocols             = ["Any"]
                destination_ports     = ["443"]
                source_addresses      = ["10.0.0.0/24"]
                destination_addresses = ["192.168.0.0/16"]
              },
            ]
          },
        ]
      }
    },
  ]
}

# AZURE_FIREWALL_POLICY_RULE_COLLECTION_GROUP MODULE REFERENCE
module "azure_firewall_rule_collection_group" {
  source = "../../Landing Zone Modules/firewall_policy_rule_collection_group"

  firewall_policy_rule_collection_group_data = var.firewall_policy_rule_collection-group_data[0]
}


# AZURE_FIREWALL_POLICY_RULE_COLLECTION_GROUP VARIABLE
variable "firewall_policy_rule_collection_group_data" {
  description = "Configuration for Azure Firewall Policy Rule Collection Group."

  type = list(map(object({
    # Required
    enabled 	= bool
    name                = string
    firewall_policy_id  = string
    priority            = number

    # Optional
    application_rule_collection = optional(object({
      name    = string
      action  = string
      priority = number

      rule = object({
        name                  = string
        description           = optional(string)
        protocols             = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_urls      = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        terminate_tls         = optional(bool)
        web_categories        = optional(list(string))
      })
    }))

    nat_rule_collection = optional(object({
      name            = string
      action          = string
      priority        = number

      rule = object({
        name               = string
        protocols          = list(string)
        source_addresses   = optional(list(string))
        source_ip_groups   = optional(list(string))
        destination_address = optional(string)
        destination_ports  = list(string)
        translated_address = optional(string)
        translated_fqdn    = optional(string)
        translated_port    = number
      })
    }))

    network_rule_collection = optional(object({
      name            = string
      action          = string
      priority        = number

      rules = list(object({
	enabled			= bool
        name			= string
        protocols		= list(string)
        destination_ports	= list(string)
        source_addresses	= optional(list(string))
        source_ip_groups	= optional(list(string))
        destination_addresses	= optional(list(string))
        destination_ip_groups	= optional(list(string))
        destination_fqdns	= optional(list(string))
      }))
    }))
  })))
}