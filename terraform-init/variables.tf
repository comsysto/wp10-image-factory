variable "state_rg_location" {
  default     = "westeurope"
  description = "Location of the resource group"
}

variable "prefix" {
  type        = string
  default     = "wp10dev2"
  description = "Prefix of the resource name"
}

variable "state_env_tag" {
  type        = string
  default     = "dev"
  description = "Environment tag applied to all created resources"
}

variable "state_project_tag" {
  type        = string
  default     = "wp10"
  description = "Project tag applied to all created resources"
}

