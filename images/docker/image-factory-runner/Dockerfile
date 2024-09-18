FROM ubuntu:22.04

ARG RUNNER_VERSION=2.319.1
ARG RUNNER_ARCH=arm64

ENV DEBIAN_FRONTEND=noninteractive \
  USER_NAME=gha \
  USER_GROUP=gha \
  USER_UID=1001 \
  USER_GID=1001 \
  USER_HOME=/opt/gha

# Update and install packadges and dependencies
RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install --no-install-recommends -y \
  ca-certificates \
  curl \
  wget \
  unzip \
  vim \
  git \
  jq


# Create runner user
RUN mkdir -p ${USER_HOME} && \
  groupadd -g ${USER_GID} ${USER_GROUP} && \
  useradd -r -u ${USER_UID} -g ${USER_GID} -d ${USER_HOME} -s /sbin/nologin -c "GitHub Actions User" ${USER_NAME} && \
  chown ${USER_GROUP}:${USER_NAME} ${USER_HOME}

WORKDIR ${USER_HOME}

# Download GitHub Actions runner
RUN mkdir actions-runner && \
  cd actions-runner && \
  curl -o actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz && \
  tar xzf ./actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz

# Install additional dependencies
RUN actions-runner/bin/installdependencies.sh

# Add start script and make it executable
ADD scripts/start-github-runner.sh start-github-runner.sh
RUN chmod +x start-github-runner.sh

# Set runner user
USER ${USER_NAME}

# Set start script as an entrypoint
ENTRYPOINT ["./start-github-runner.sh"]
