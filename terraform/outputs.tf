output "network_name" {
  value = module.network.resource_group.name
}

output "runner_data" {
  value = module.runner
} 