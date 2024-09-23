variable "resource_group_location" {
  type        = string
  description = "Location of the resource group"
}
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}
variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "firewall_sku_tier" {
  type        = string
  description = "Firewall SKU. Premium is required for DNS whitelisting features"
  default     = "Premium" # Valid values are Standard and Premium
  validation {
    condition     = contains(["Standard", "Premium"], var.firewall_sku_tier)
    error_message = "The SKU must be one of the following: Standard, Premium"
  }
}

variable "public_subnet_id" {
  type        = string
  description = "Id of public subnet for the firewall"
}

variable "private_subnet_id" {
  type        = string
  description = "Id of private subnet for the route table association"
}

variable "virtual_network" {
  description = "Virtual network object output from the `network` module"
}

variable "env_tag" {
  type        = string
  description = "Environment tag applied to all created resources"
}

variable "project_tag" {
  type        = string
  description = "Project tag applied to all created resources"
}