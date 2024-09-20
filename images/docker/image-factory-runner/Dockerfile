FROM ubuntu:22.04

ARG RUNNER_VERSION=2.319.1
ARG RUNNER_ARCH=x64

ENV DEBIAN_FRONTEND=noninteractive \
    USER_NAME=gha \
    USER_GROUP=gha \
    USER_HOME=/opt/gha

# Update and install packadges and dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \
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
    wget && \
    rm -rf /var/lib/apt/lists/*


# Create runner user
RUN mkdir -p ${USER_HOME}/containers && \
    useradd -r -d ${USER_HOME} -s /sbin/nologin -c "GitHub Actions User" ${USER_NAME} && \ 
    chown ${USER_GROUP}:${USER_NAME} ${USER_HOME}

# Add podman configuration file(s) 
ADD files/containers.conf ${USER_HOME}/containers/containers.conf
ADD files/registries.conf ${USER_HOME}/containers/registries.conf
RUN chown ${USER_GROUP}:${USER_NAME} ${USER_HOME}

# Setup for rootless podman
RUN usermod --add-subuids 100000-165535 --add-subgids 100000-165535 ${USER_NAME}

# Enable rootless podman to setup namespace using newuidmap
# - referrence: https://github.com/containers/podman/issues/2788#issuecomment-1016301663
RUN chmod u-s /usr/bin/newuidmap /usr/bin/newgidmap && \
    setcap cap_setuid+eip /usr/bin/newuidmap && \
    setcap cap_setgid+eip /usr/bin/newgidmap 

# Change to runner workdir
WORKDIR ${USER_HOME}

# Download GitHub Actions runner
RUN mkdir actions-runner && \
    cd actions-runner && \
    curl -o actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz && \
    chown -R ${USER_NAME} ${USER_HOME}

# Install additional dependencies
RUN actions-runner/bin/installdependencies.sh

# Add start script and make it executable
ADD scripts/start-github-runner.sh start-github-runner.sh
RUN chmod +x start-github-runner.sh

# Install packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=${RUNNER_ARCH}] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update -y && \
    apt-get install packer

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Trivy
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - && \
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install trivy

# Add gha to sudoers --> TESTING ONLY!!!
RUN echo 'gha ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/gha

# Set runner user
USER ${USER_NAME}

# Set start script as an entrypoint
ENTRYPOINT ["./start-github-runner.sh"]
