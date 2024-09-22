# WP10 Image Factory

The WP10 Image Factory is a self-service system designed to facilitate the creation of VM and container images. This repository serves as the primary resource for deploying the underlying infrastructure through GitHub Actions workflows that automate the deployment and configuration processes.

Additionally, it provides reusable GitHub Actions workflows that users can invoke from their own repositories for image-building purposes.


## Repository Structure

- [`ansible/`](./ansible/): Contains Ansible configuration and playbooks for setting up the VM.
- [`docs/`](./docs/): Documentation files related to the project.
- [`images/`](./images/): Holds the Docker and Packer image configurations.
  - [`docker/`](./images/docker/): Custom Docker image for GitHub runners.
  - [`packer/`](./images/packer/): Packer template for building VM images.
- [`terraform/`](./terraform/): Terraform scripts for deploying various Azure components (resource group, vnet, subnet, runner host vm etc.)
  - [`modules/`](./terraform/modules/): Reusable Terraform modules for Azure resources.
  - [`scripts/`](./terraform/scripts/): Helper scripts for automation.
- [`terraform-init/`](./terraform-init/): Terraform scripts for setting up an Azure Storage Account used as Terraform state storage

<br />

## Prerequisites

To use this repository, the following prerequisites are needed:

- An Azure subscription
- An Azure service principal with credentials (Client ID, Client Secret, and Tenant ID)
- GitHub Actions secrets and variables configured in the repo

### Repository Secrets and variables

The following GitHub secrets need to be configured in the repository to run GitHub Actions workflows:

- `ACR_PASSWORD`: Password for Azure Container Registry.
- `ACR_USERNAME`: Username for Azure Container Registry.
- `AZURE_CLIENT_ID`: Client ID of the Azure service principal.
- `AZURE_CLIENT_SECRET`: Client Secret of the Azure service principal.
- `AZURE_SUBSCRIPTION_ID`: Subscription ID for the Azure account.
- `AZURE_TENANT_ID`: Tenant ID of the Azure service principal.
- `AZURE_VM_SSH_KEY`: SSH key for Azure VM access.
- `AZURE_IF_RUNNER_IP`: IP address of the image factory runner.
- `JUMPHOST_IP`: IP address of the Azure jump host.
- `RUNNER_HOST_IP`: IP address for the VM hosting the Image Factory runners in the air-gapped environment.
- `RUNNER_HOST_IP_DEVEL`: IP address for the VM hosting the Image Factory runners in the development environment (public subnet).
- `SSH_KEY`: SSH key for accessing the runner host VM in the air-gapped environment.
- `SSH_KEY_DEVEL`: SSH key for accessing the runner host VM in the development environment.
- `GH_PAT_TOKEN`: Personal Access Token for GitHub used for Image Factory runner registration.
- `REGISTRY`: Azure Container Registry registry URL.

The following GitHub repository variables need to be configured in the repository to run GitHub Actions workflows:

- `ACR_RUNNER_IMAGE_NAME`: Name of the runner image in Azure Container Registry.
- `AZURE_ACG`: Azure Compute Gallery name.
- `AZURE_LOCATION`: Azure region where resources will be deployed.
- `AZURE_RESOURCE_GROUP`: Resource group in Azure for the deployment.
- `GH_OWNER`: GitHub owner (user or organization) where Image Factory runners will be connected to.
- `GH_REPO`: GitHub repository name where Image Factory runners will be connected to.
- `VM_ENV`: Environment setting for the runner host VM. Valid values are `"development"` and `"air-gapped"`.

<br />

## Building Platform Images

Platform Images are built using GitHub Actions workflows. The following images are used in the main platform deployment:
- Runner Host Image (virtual machine)
- Runner (container)

### Building Runner Host Image

The [`packer-build-if-runner.yml`](.github/workflows/packer-build-if-vm.yml) workflow is used to build the runner host VM image with Packer and push it to the Azure Compute Gallery (ACG).  
Packer image and code used in this GitHub action can be found in the [`images/packer`](./images/packer) folder.

### Building Runner Container Image

The [`docker-build-if-runner.yml`](.github/workflows/docker-build-if-runner.yml) workflow is used to build the runner container image with Docker and push it to the Azure Container Registry (ACR).  
Docker image and all resources needed in the Docker build action can be found in the [`images/docker`](./images/docker) folder.