output "private_key_encrypted" {
  value = data.external.encrypt_ssh_key.result
}
output "jumphost_ip_encrypted" {
  value = data.external.encrypt_jumphost_ip.result
}
output "runner_host_ip_encrypted" {
  value = data.external.encrypt_runner_host_ip.result
}