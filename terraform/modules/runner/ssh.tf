resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2024-07-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2024-07-01"
  name      = var.ssh_key_name
  location  = var.resource_group_location
  parent_id = var.resource_group_id
}

resource "local_sensitive_file" "private_key" {
  content  = azapi_resource_action.ssh_public_key_gen.output.privateKey
  filename = "private_key.pem"
}