output "resource_group_name" {
  value = module.network
}

output "key_data" {
  value = module.runner.key_data
}