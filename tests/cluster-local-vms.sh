#!/bin/bash
#
# Tests for cluster-local-vms playbook.
set -e

cd cluster-local-vms

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
