# GitHub Actions Runner Docker Image

This directory contains the Dockerfile and supporting scripts to build a Docker image for the container that will be provided to Image Factory users as a GitHub Actions runner. The image is based on Ubuntu 22.04 and includes all necessary dependencies and configurations to run GitHub Actions workflows.

## Dockerfile Overview

The Dockerfile performs the following tasks:

1. **Base Image**: Starts with an Ubuntu 22.04 base.
2. **Install Dependencies**: Updates the package list, upgrades the system, and installs required packages like `curl`, `git`, `podman`, `qemu`, and more.
3. **Create User**: Creates a `gha` user with a home directory at `/opt/gha`.
4. **Setup Podman**: Configures rootless `podman` for the `gha` user.
5. **Download GitHub Actions Runner**: Downloads and extracts the GitHub Actions runner binaries.
6. **Install Additional Tools**: Installs tools such as Packer, Azure CLI, and Trivy.
7. **Set Permissions and Entrypoint**: Sets necessary file permissions and specifies the start script as the entry point.

### Entrypoint

The [`start-github-runner.sh`](./scripts/start-github-runner.sh) script performs the following actions:

1. Reads the GitHub Personal Access Token (PAT) from the `/pat/.token` file.
2. Logs into the specified container registry using the provided credentials.
3. Configures Podman to use the container registry.
4. Requests a runner registration token from GitHub.
5. Deletes the PAT token from the runner filesystem.
6. Sets up QEMU for emulating different CPU architectures.
7. Configures the runner with GitHub using the registration token.
8. Starts the runner in an unattended, ephemeral, and replaceable mode.

## GitHub Actions Workflow

The GitHub Actions workflow [`.github/workflows/docker-build-if-runner.yml`](../../.github/workflows/docker-build-if-runner.yml) is triggered on pushes to this directory or manual dispatch and performs the following steps:

1. **Checkout Repository**: Checks out the repository to the runner.
2. **Log in to Azure Container Registry**: Logs in to the Azure Container Registry using the provided credentials.
3. **Build Docker Image**: Builds the Docker image using the Dockerfile in this directory.
4. **Push Docker Image**: Pushes the built image to the Azure Container Registry.
5. **Tag and Push as Latest**: Optionally tags the image as `latest` and pushes it.
