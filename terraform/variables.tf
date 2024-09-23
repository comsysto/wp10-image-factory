locals {
  prefix     = "wp10-tf-${terraform.workspace}"
  acr_prefix = replace("${local.prefix}", "-", "")
}

variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group"
}

variable "repository" {
  default     = "wp10-image-factory"
  description = "Repository in which to save output secrets"
}

variable "local_development" {
  type        = bool
  default     = false
  description = "Development purposes only: set to 'true' when running terraform apply locally. Outputs SSH private key to the terraform directory"
}

variable "runner_image_id" {
  type        = string
  default     = "/subscriptions/218f1214-da01-4678-8025-4e14a989e315/resourceGroups/wp10-tf-dev-rg/providers/Microsoft.Compute/galleries/wp10ImageFactoryGallery/images/image-factory-vm/versions/1.0.34"
  description = "Shared Image Gallery ID of the runner VM image"
}


variable "env_tag" {
  type        = string
  default     = "dev"
  description = "Environment tag applied to all created resources"
}

variable "project_tag" {
  type        = string
  default     = "wp10"
  description = "Project tag applied to all created resources"
}