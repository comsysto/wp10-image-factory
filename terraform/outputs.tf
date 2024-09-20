output "network_name" {
  value = module.network.resource_group.name
}

output "runner_data" {
  value = (var.local_development == true ? module.runner : null)
}

output "encrypted_gh_secrets" {
  value = (var.local_development == true ? module.github_output : null)
}