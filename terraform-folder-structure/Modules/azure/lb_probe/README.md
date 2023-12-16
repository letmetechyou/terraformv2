# LB_PROBE VALUES EXAMPLE
lb_probe_data = {
  probe1 = {
    enabled             = true
    port                = 80
    loadbalancer_id     = "lb-id-1"
    name                = "probe-1"
    interval_in_seconds = 15
    request_path        = "/health"
    protocol            = "Http"
    probe_threshold     = 2
    number_of_probes    = 3
  },
  probe2 = {
    enabled             = true
    port                = 443
    loadbalancer_id     = "lb-id-2"
    name                = "probe-2"
    interval_in_seconds = 20
    request_path        = "/status"
    protocol            = "Https"
    probe_threshold     = 1
    number_of_probes    = 4
  },
}

# LB_PROBE MODULE REFERENCE
module "lb_probe" {
        source = "./Modules/lb_probe"

        lb_probe_data = var.lb_probe_data
}

# LB_PROBE VARIABLE
variable "lb_probe_data" {
  type = map(object({
    # Required
    enabled         = bool
    port            = number
    loadbalancer_id = string
    name            = string

    # Optional
    interval_in_seconds = optional(number)
    request_path        = optional(string)
    protocol            = optional(string)
    probe_threshold     = optional(number)
    number_of_probes    = optional(number)

    # Optional Dynamic Blocks
  }))
}
