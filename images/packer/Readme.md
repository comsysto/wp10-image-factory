# packer

This directory contains 2 repositories:

- image-factory-vm
- user-packer

Both directories are used to build VM images with Packer and store them in Azure Shared Image Gallery however there is difference in when one is used:

## image-factory-vm

This directory contains Packer scripts to build Image Factory VM which will host GitHub Actions runner.

Produced VM image version is then used by Terraform module during deployment:

- runner

To trigger image rebuild following GitHub Actions Workflow needs to be executed:

- Build Image Factory VM

## user-packer

This directory contains Packer scripts to build user VM images produced by Image Factory.
These scripts are used whenever user calls reusable workflow: "Reusable workflow - build packer VM"
