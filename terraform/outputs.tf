output "network_name" {
  value       = module.network.resource_group.name
  description = "Name of the created resource group."
}

output "runner_data" {
  value       = (var.local_development == true ? module.runner : null)
  description = "Prints out runner data if `local_development` is set to `true`."
}