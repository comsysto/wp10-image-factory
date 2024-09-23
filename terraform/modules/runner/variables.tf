variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "resource_group_id" {
  type        = string
  description = "Id of the resource group"
}

variable "public_subnet_id" {
  type        = string
  description = "Id of the public subnet"
}

variable "private_subnet_id" {
  type        = string
  description = "Id of the private subnet"
}

variable "username" {
  type        = string
  description = "The username for the default admin account that will be created on the new VM"
  default     = "azureadmin"
}

variable "ssh_key_name" {
  type        = string
  description = "Name of the generated SSH key for the VM"
  default     = "runnersshkey"
}


variable "runner_image_id" {
  type        = string
  description = "Shared Image Gallery ID of the runner VM image"
}

variable "env_tag" {
  type        = string
  description = "Environment tag applied to all created resources"
}

variable "project_tag" {
  type        = string
  description = "Project tag applied to all created resources"
}