# Configure the custom landing zones to deploy in
# addition to the core resource hierarchy
locals {
  custom_landing_zones = {
    "${var.root_id}-Production" = {
      display_name               = "${upper(var.root_id)} Production"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = ["81ce3a0d-94c0-4075-b64c-f1dea416448a",
                                    "d5319e2c-c33a-4167-9a50-096e4fd99c94"]
      archetype_config = {
        archetype_id   = "es_landing_zones"
        parameters     = {}
        access_control = {
          "[LMTY] VirtualNetwork-Contributor": ["98614ff9-6e26-45ae-9e7f-05809636fbf5"]
        }
      }
    }
    "${var.root_id}-Development" = {
      display_name               = "${upper(var.root_id)} Development"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "default_empty"
        parameters = {}
        access_control = {}
      }
    }
      "${var.root_id}-connectivityus" = {
      display_name               = "${upper(var.root_id)} Connectivity US"
      parent_management_group_id = "${var.root_id}-connectivity"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_corp"
        parameters = {}
        access_control = {}
      }
    }
  }
}
