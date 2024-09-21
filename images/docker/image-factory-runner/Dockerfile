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
    qemu \
    qemu-user-static \
    slirp4netns \
    software-properties-common \
    sudo \
    unzip \
    vim \
    wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# # Create runner user
# RUN mkdir -p ${USER_HOME} && \
#     useradd -r -d ${USER_HOME} -s /sbin/nologin -c "GitHub Actions User" ${USER_NAME}

# # Add podman configuration file(s) and permissions
# ADD files/containers.conf ${USER_HOME}/.config/containers/containers.conf
# ADD files/registries.conf ${USER_HOME}/.config/containers/registries.conf
# RUN mkdir -p ${USER_HOME}/.local/share/containers && \
#     chown -R ${USER_GROUP}:${USER_NAME} ${USER_HOME}

# Create runner user and necessary directories
RUN groupadd -r ${USER_GROUP} && \
    useradd -r -d ${USER_HOME} -s /sbin/nologin -g ${USER_GROUP} -c "GitHub Actions User" ${USER_NAME} && \
    mkdir -p ${USER_HOME}/.config/containers && \
    chown -R ${USER_NAME}:${USER_GROUP} ${USER_HOME}

# Setup for rootless podman
# referrence: https://github.com/containers/podman/issues/2788#issuecomment-1016301663
RUN usermod --add-subuids 100000-165535 --add-subgids 100000-165535 ${USER_NAME} && \
    chmod u-s /usr/bin/newuidmap /usr/bin/newgidmap && \
    setcap cap_setuid+eip /usr/bin/newuidmap && \
    setcap cap_setgid+eip /usr/bin/newgidmap 

# # QEMU setup
# RUN update-binfmts --enable qemu-aarch64 && \
#     update-binfmts --enable qemu-arm

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
COPY scripts/start-github-runner.sh ${USER_HOME}/start-github-runner.sh
RUN chmod +x start-github-runner.sh

# Install Packer, Azure CLI, and Trivy
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=${RUNNER_ARCH}] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update -y && \
    apt-get install -y packer && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - && \
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y trivy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Update sudoers file to enable PAT token removal on runner startup
COPY files/gha /etc/sudoers.d/gha

# Set runner user
USER ${USER_NAME}

# Set start script as an entrypoint
ENTRYPOINT ["./start-github-runner.sh"]
