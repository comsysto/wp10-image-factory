#!/bin/bash

GITHUB_OWNER=$GITHUB_OWNER
GITHUB_REPOSITORY=$GITHUB_REPOSITORY
GITHUB_TOKEN=$(cat /.pat/.token)
GITHUB_RUNNER_NAME="if-runner-$(hostname)"

echo "Log in to container registry:"
podman login "$CONTAINER_REGISTRY" \
  --username "$CONTAINER_REGISTRY_USERNAME" \
  --password "$CONTAINER_REGISTRY_PASSWORD"

# REG_TOKEN Token will be available only during container startup
echo "Getting runner registration token from GitHub..."
REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

echo "Deleting PAT token from runner filesystem..."
sudo umount /.pat
sudo rmdir /.pat

echo "Connect runner to GitHub:"
cd actions-runner
./config.sh \
  --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPOSITORY} \
  --token ${REG_TOKEN} \
  --name ${GITHUB_RUNNER_NAME} \
  --unattended \
  --ephemeral \
  --replace \
  --disableupdate

./run.sh & wait $!
