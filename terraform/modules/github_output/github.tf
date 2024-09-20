data "github_actions_public_key" "wp10" {
  repository = var.repository
}

data "external" "encrypt_ssh_key" {
  program = ["venv/Scripts/python", "${path.module}/encrypt_github_secrets.py"]

  query = {
    public_key = data.github_actions_public_key.wp10.key
    value      = var.ssh_key
  }
}
resource "github_actions_secret" "ssh_key_gh_secret" {
  repository      = var.repository
  secret_name     = "SSH_KEY"
  encrypted_value = data.external.encrypt_ssh_key.result.encrypted_value
}

data "external" "encrypt_jumphost_ip" {
  program = ["venv/Scripts/python", "${path.module}/encrypt_github_secrets.py"]

  query = {
    public_key = data.github_actions_public_key.wp10.key
    value      = var.jumphost_ip
  }
}
resource "github_actions_secret" "jumphost_ip_gh_secret" {
  repository      = var.repository
  secret_name     = "JUMPHOST_IP"
  encrypted_value = data.external.encrypt_jumphost_ip.result.encrypted_value
}

data "external" "encrypt_runner_host_ip" {
  program = ["venv/Scripts/python", "${path.module}/encrypt_github_secrets.py"]

  query = {
    public_key = data.github_actions_public_key.wp10.key
    value      = var.runner_host_ip
  }
}
resource "github_actions_secret" "runner_host_ip_gh_secret" {
  repository      = var.repository
  secret_name     = "RUNNER_HOST_IP"
  encrypted_value = data.external.encrypt_runner_host_ip.result.encrypted_value
}