#!/bin/bash
#
# Tests for cluster-local-vms playbook.
set -e

cd cluster-local-vms

# If on Travis CI, update Docker's configuration.
if [ "$TRAVIS" == "true" ]; then
  mkdir /tmp/docker
  echo '{
    "experimental": true,
    "storage-driver": "overlay2"
  }' | sudo tee /etc/docker/daemon.json
  sudo service docker restart
fi

# Install Ansible and required dependencies.
pip install ansible ansible-lint

# Install requirements.
ansible-galaxy install -r requirements.yml

# Lint the Cluster playbook.
ansible-lint main.yml

# Set up the Cluster containers.
docker-compose up -d

# Execute the Cluster playbook.
ansible-playbook -i inventory-docker main.yml
