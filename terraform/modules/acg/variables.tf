variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
}

variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "Private endpoint subnet"
  type        = string
}

variable "virtual_network" {
  description = "Virtual network"
}
