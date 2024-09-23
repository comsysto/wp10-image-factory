variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources."
}

variable "virtual_network" {
  description = "Virtual network for the private DNS zone."
}

variable "subnet_id" {
  type        = string
  description = "Id of the subnet where the private endpoint should be created."
}

variable "env_tag" {
  type        = string
  description = "Environment tag applied to all created resources."
}

variable "project_tag" {
  type        = string
  description = "Project tag applied to all created resources."
}