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
  description = "Virtual network output."
}

variable "subnet_id" {
  type        = string
  description = "Id of the subnet."
}