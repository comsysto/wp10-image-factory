#!/bin/bash

GITHUB_OWNER=$GITHUB_OWNER
GITHUB_REPOSITORY=$GITHUB_REPOSITORY
GITHUB_TOKEN=$(cat /.pat/.token)
GITHUB_RUNNER_NAME="image-factory-runner"

echo "Log in to container registry:"
podman login "$CONTAINER_REGISTRY" \
  --username "$CONTAINER_REGISTRY_USERNAME" \
  --password "$CONTAINER_REGISTRY_PASSWORD"

echo "Getting runner registration token from GitHub..."
REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

# Add this part once PAT token generation is set up on the runner host VM 
#   - new PAT token will be generated as a pre task to each runner container start
#
# echo "Removing PAT token from runner filesystem"
# rm -rf /.pat/.token

echo "Connect runner to GitHub:"
cd actions-runner
./config.sh \
  --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPOSITORY} \
  --token ${REG_TOKEN} \
  --name ${RUNNER_NAME} \
  --unattended \
  --ephemeral \
  --replace \
  --disableupdate

# TODO: add remove REG_TOKEN

./run.sh & wait $!
