# Get the connectivity and management configuration
# settings from outputs via the respective terraform
# remote state files

data "terraform_remote_state" "connectivity" {
  backend = "local"

  config = {
    path = "${path.module}/../2_connectivity/connectivity.tfstate"
  }
}

data "terraform_remote_state" "management" {
  backend = "local"

  config = {
    path = "${path.module}/../3_management/management.tfstate"
  }
}
