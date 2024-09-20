locals {
  prefix     = "wp10-tf-${terraform.workspace}"
  acr_prefix = replace("${local.prefix}", "-", "")
}

variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "repository" {
  default     = "wp10-image-factory"
  description = "Repository in which to save output secrets."
}

variable "local_development" {
  type        = bool
  default     = false
  description = "Development purposes only: set to 'true' when running terraform apply locally. Outputs SSH private key to the terraform directory."
}
