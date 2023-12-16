# LB_RULE VALUES EXAMPLE
lb_rule_data = {
  rule1 = {
    enabled                        = true
    name                           = "rule-1"
    frontend_port                  = 80
    protocol                       = "Tcp"
    loadbalancer_id                = "lb-id-1"
    frontend_ip_configuration_name = "frontend-ip-config-1"
    backend_port                   = 8080
    probe_id                       = "probe-id-1"
    disable_outbound_snat          = true
    idle_timeout_in_minutes        = 5
    load_distribution              = "Default"
    backend_address_pool_ids       = ["backend-pool-id-1", "backend-pool-id-2"]
    enable_tcp_reset               = false
    enable_floating_ip             = true
  },
  rule2 = {
    enabled                        = true
    name                           = "rule-2"
    frontend_port                  = 443
    protocol                       = "Https"
    loadbalancer_id                = "lb-id-2"
    frontend_ip_configuration_name = "frontend-ip-config-2"
    backend_port                   = 8443
    probe_id                       = "probe-id-2"
    disable_outbound_snat          = false
    idle_timeout_in_minutes        = 10
    load_distribution              = "SourceIP"
    backend_address_pool_ids       = ["backend-pool-id-3", "backend-pool-id-4"]
    enable_tcp_reset               = true
    enable_floating_ip             = false
  },
}

# LB_RULE MODULE REFERENCE
module "lb_rule" {
        source = "./Modules/lb_rule"

        lb_rule_data = var.lb_rule_data
}

# LB_RULE VARIABLE
variable "lb_rule_data" {
  type = map(object({
    # Required
    enabled                        = bool
    name                           = string
    frontend_port                  = number
    protocol                       = string
    loadbalancer_id                = string
    frontend_ip_configuration_name = string
    backend_port                   = number

    # Optional
    probe_id                 = optional(string)
    disable_outbound_snat    = optional(bool)
    idle_timeout_in_minutes  = optional(number)
    load_distribution        = optional(string)
    backend_address_pool_ids = optional(list(string))
    enable_tcp_reset         = optional(bool)
    enable_floating_ip       = optional(bool)

    # Optional Dynamic Blocks
  }))
}
