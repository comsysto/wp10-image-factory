output "private_key_encrypted" {
  value       = data.external.encrypt_ssh_key.result
  description = "Encrypted VM private key. For development purposes"
}
output "jumphost_ip_encrypted" {
  value       = data.external.encrypt_jumphost_ip.result
  description = "Encrypted Jumphost IP. For development purposes"
}
output "runner_host_ip_encrypted" {
  value       = data.external.encrypt_runner_host_ip.result
  description = "Encrypted Runner host IP. For development purposes"
}