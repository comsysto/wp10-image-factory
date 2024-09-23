# Packer

This project contains two main directories:

1. `image-factory-vm`
2. `user-packer`

Both directories are used to build VM images with Packer and store them in the Azure Shared Image Gallery. However, they are used in different contexts.

## Image Factory VM

This directory includes Packer scripts to build the Image Factory VM, which hosts a GitHub Actions runner.

### VM Configuration Script

The Image Factory VM is configured using a shell script that performs the following tasks:

- Sets the DEBIAN_FRONTEND to noninteractive to avoid user prompts during the package installation process.
- Updates and upgrades the system packages.
- Installs necessary packages such as `apt-transport-https`, `buildah`, `ca-certificates`, `curl`, `git`, `gnupg`, `jq`, `libcap2-bin`, `lsb-release`, `podman`, `slirp4netns`, `software-properties-common`, `unzip`, `vim`, and `wget`.
- Performs a clean-up of the package lists.
- Installs the Azure CLI.

### Triggering an Image Rebuild

To trigger a rebuild of the Image Factory VM, execute the following GitHub Actions Workflow: [.github/workflows/packer-build-if-vm.yml](.github/workflows/packer-build-if-vm.yml)

## User Packer Template

The `user-packer` directory contains Packer scripts to build user VM images. These images are produced by the Image Factory VM.
These scripts come into play whenever a user calls the reusable workflow: [.github/workflows/packer-build-if-vm.yml](.github/workflows/packer-build-if-vm.yml)

By following these guidelines, you can efficiently build and deploy VM images using Packer and GitHub Actions.