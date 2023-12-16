variable "subscription_id_connectivity" {
  description = "The connectivity subscription"
  default = "f23f047e-1868-4aea-b9a6-0c297d1d5a43"
}

variable "root_id" {
  description = "The name appended to landing zones"
  default = "lmty"
}

variable "enable_ddos_protection" {
  description = "ddos protection"
  default = false
}

variable "primary_location" {
  description = "primary hub"
  default = "centralus"
}

variable "secondary_location" {
  description = "secondary hub"
  default = "eastus"
}