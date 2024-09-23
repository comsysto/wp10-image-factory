# Ansible

This directory contains Ansible code for setting up the runner host VM for the WP10 Image Factory.

## Ansible Playbook

The main Ansible playbook [`configure-image-factory-vm.yml`](./configure-image-factory-vm.yml) is responsible for calling the [`podman`](./roles/podman) role to configure the runner host VM.

## Podman Role

The [`podman`](./roles/podman) role configures Podman on the runner host VM. It sets up necessary directories, templates configuration files and GitHub PAT, logs into the Azure Container Registry, pulls the runner image, and creates the runner container. It also generates a systemd unit file for the runner container, ensuring it is managed by systemd, which enables automatic restarts and ensures that the container starts on system boot.

> **Important Note:** Podman runner containers are currently rootless, but are still running with "--priviledged" flag. Further setup is needed in Ansible podman role to remove this flag.

## GitHub Workflow

The Ansible playbook is executed through the GitHub Actions workflow [`ansible-configure-if-vm.yml`](../.github/workflows/ansible-configure-if-vm.yml). This workflow handles both development and air-gapped environments, and templates the necessary SSH keys and inventory files accordingly.

### Workflow Steps

1. Checkout Repository
2. Template SSH Key and Inventory (based on the environment)
3. Template Ansible Variables
4. Install and Configure Ansible
5. Run Ansible Playbook