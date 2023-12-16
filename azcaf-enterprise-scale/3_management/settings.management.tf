# Configure custom management resources settings
locals {
  configure_management_resources = {
    settings = {
      log_analytics = {
        config = {
          # Set a custom number of days to retain logs
          retention_in_days = var.log_retention_in_days
        }
      }
    }
    # Set the default location
    location = var.primary_location
    # Create a custom tags input
  }
}
