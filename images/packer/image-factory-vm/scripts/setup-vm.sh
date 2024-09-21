#!/bin/bash

set -e

# Set the DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Update and upgrade the system
apt-get update
apt-get upgrade -y

# Deprovision user
/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync

# Install required packages
apt-get install --no-install-recommends -y \
    apt-transport-https \
    buildah \
    ca-certificates \
    curl \
    git \
    gnupg \
    jq \
    libcap2-bin \
    lsb-release \
    podman \
    slirp4netns \
    software-properties-common \
    unzip \
    vim \
    wget

# Clean up
rm -rf /var/lib/apt/lists/*

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Set up Trivy repository and install Trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list
apt-get update
apt-get install -y trivy
