#!/bin/bash

# Test a curl command.
curl --head https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Run a docker container.
docker run -d --name curltest geerlingguy/docker-debian10-ansible sleep infinity

# Install curl in the container.
docker exec curltest bash -c "apt update && apt install -y curl"

# Test a curl command in that docker container.
docker exec curltest bash -c "curl --head https://packages.cloud.google.com/apt/doc/apt-key.gpg"

# Test convoluted curl command in that docker container.
docker exec -i curltest /bin/sh -c "sudo -H -S -n -u root /bin/sh -c 'curl --head https://packages.cloud.google.com/apt/doc/apt-key.gpg'"

# Kill that docker container.
docker rm -f curltest

# Try running docker-compose-based things and see if DNS resolves.
cd cluster-local-vms
docker-compose up -d
docker-compose exec kube2 bash -c "apt update && apt install -y curl"
docker-compose exec kube2 bash -c "curl --head https://packages.cloud.google.com/apt/doc/apt-key.gpg"
