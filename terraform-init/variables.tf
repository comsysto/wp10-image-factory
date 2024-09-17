variable "state_rg_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "prefix" {
  type        = string
  default     = "cariad-wp10"
  description = "Prefix of the resource name"
}

