variable "repository" {
  default     = "wp10-image-factory"
  type        = string
  description = "Repository in which to save output secrets."
}

variable "ssh_key" {
  type        = string
  description = "Private SSH key created during VM deployment."
}


variable "jumphost_ip" {
  type        = string
  description = "Public IP address of the jumphost VM."
}

variable "runner_host_ip" {
  type        = string
  description = "Private IP address of the runner host VM."
}
