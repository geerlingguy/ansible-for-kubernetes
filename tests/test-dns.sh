#!/bin/bash

# Test a curl command.
curl --head https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Run a docker container.
docker run -d --name curltest geerlingguy/docker-debian10-ansible sleep infinity

# Install curl in the container.
docker exec curltest bash -c "apt update && apt install -y curl"

# Test a curl command in that docker container.
docker exec curltest bash -c "curl --head https://packages.cloud.google.com/apt/doc/apt-key.gpg"
