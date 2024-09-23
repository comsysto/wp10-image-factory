# WP10 Image Factory

The WP10 Image Factory is a self-service system designed to facilitate the creation of VM and container images. This repository serves as the primary resource for deploying the underlying infrastructure through GitHub Actions workflows that automate the deployment and configuration processes.

Additionally, it provides reusable GitHub Actions workflows that users can invoke from their own repositories for image-building purposes.

## Table of Contents
- [WP10 Image Factory](#wp10-image-factory)
  - [Table of Contents](#table-of-contents)
  - [Repository Structure](#repository-structure)
  - [Prerequisites](#prerequisites)
    - [Repository Secrets and variables](#repository-secrets-and-variables)
  - [Building Platform Images](#building-platform-images)
    - [Building Runner Host Image](#building-runner-host-image)
    - [Building Runner Container Image](#building-runner-container-image)
  - [Platform Deployment](#platform-deployment)
    - [Executing the Workflow](#executing-the-workflow)
  - [Platform Configuration](#platform-configuration)
    - [Executing the Workflow](#executing-the-workflow-1)
  - [Image Factory Reusable Workflows](#image-factory-reusable-workflows)
    - [Reusable Docker Image Workflow](#reusable-docker-image-workflow)
    - [Reusable Packer Image Workflow](#reusable-packer-image-workflow)
    - [Example User Repository](#example-user-repository)

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

The following images are used in the main platform deployment:
- Runner Host Image (virtual machine)
- Runner (container)  

Platform Images are built using GitHub Actions workflows. 

### Building Runner Host Image

The [`packer-build-if-runner.yml`](.github/workflows/packer-build-if-vm.yml) workflow is used to build the runner host VM image with Packer and push it to the Azure Compute Gallery (ACG).  
Packer image and code used in this GitHub action can be found in the [`images/packer`](./images/packer) folder.

### Building Runner Container Image

The [`docker-build-if-runner.yml`](.github/workflows/docker-build-if-runner.yml) workflow is used to build the runner container image with Docker and push it to the Azure Container Registry (ACR).  
Docker image and all resources needed in the Docker build action can be found in the [`images/docker`](./images/docker) folder.

<br />

## Platform Deployment

The platform deployment is managed through a `.github/workflows/terraform-deploy.yml` GitHub Actions workflow that leverages Terraform to provision and configure the necessary infrastructure on Azure.

Detailed information about the Terraform configurations and scripts can be found in the following locations:
- Terraform initialization scripts: [`terraform-init/`](./terraform-init/)
- Main Terraform scripts: [`terraform/`](./terraform/)

### Executing the Workflow

To deploy the platform, ensure the necessary GitHub secrets and variables are configured as described in the Prerequisites section. The workflow requires manual execution and user inputs, which can be provided in the GitHub Actions tab.

<br />

## Platform Configuration

Further platform configuration is done in `.github/workflows/ansible-configure-vm.yml` GitHub Actions workflow. This workflow uses Ansible to configure the deployed runner host VM.

For more detailed information about the Ansible playbooks and configurations, refer to the following locations:
- Ansible playbooks and configurations: [`ansible/`](./ansible/)

### Executing the Workflow

To configure the platform, ensure the necessary GitHub secrets and variables are configured as described in the Prerequisites section. The workflow can be found in the GitHub Actions tab and can be executed manually once infractructure is deployed with terraform.

<br />

## Image Factory Reusable Workflows

This repository provides two reusable GitHub Actions workflows that customers can call from their repositories to build Docker and Packer images.

### Reusable Docker Image Workflow

The [`reusable-workflow-docker-image.yml`](./.github/workflows/reusable-workflow-docker-image.yml) workflow is used to build Docker images. Customers can integrate this workflow into their repositories to automate the Docker image-building process.

### Reusable Packer Image Workflow

The [`reusable-workflow-packer-image.yml`](./.github/workflows/reusable-workflow-packer-image.yml) workflow is used to build Packer images. Customers can use this workflow in their repositories to automate the creation of VM images with Packer.

### Example User Repository

An example user repository that demonstrates how to call these reusable workflows can be found [here](https://github.com/comsysto/wp10-image-factory-user-1).

<br />

## GitHub Action Runners

### Multi-target architecture

Our infrastructure now supports the production of both arm64 and amd64 container images. This enhancement has been achieved by enabling multi-architecture support on our Image Factory GitHub Actions runners.

The following commands were executed to facilitate this capability:

```bash
sudo update-binfmts --enable qemu-aarch64
sudo update-binfmts --enable qemu-arm
```

By enabling these QEMU interpreters, our CI/CD pipeline can seamlessly handle and build container images for multiple architectures, empowering customers with greater flexibility and compatibility for their deployment needs.

### Quality gate and SBOM generation

Quality Gate Checking with Trivy helps us enforce quality gates automatically. This integration reduces the risk of deploying insecure or non-compliant images to production, maintaining high security.

SBOM Generation with Trivy provides detailed visibility into the components, libraries, and dependencies within our Docker images. This transparency allows us to manage software components effectively, quickly identify and mitigate vulnerabilities, and ensure compliance with licensing and regulatory requirements.

SBOM is generated in following formats:

- CycloneDX
- SPDX

Each invocation of our reusable workflow generates and uploads the results to the GitHub Actions run. The output is consolidated into a file named image-scan-results.zip.
