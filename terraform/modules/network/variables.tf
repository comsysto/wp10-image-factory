variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group"
}

variable "env_tag" {
  type        = string
  description = "Environment tag applied to all created resources"
}

variable "project_tag" {
  type        = string
  description = "Project tag applied to all created resources"
}