locals {
  prefix = "wp10-tf-${terraform.workspace}"
  acr_prefix = replace("${local.prefix}", "-", "")
}

variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}
