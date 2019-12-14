#!/bin/bash
#
# Tests for cluster-local-vms playbook.
set -e

cd cluster-local-vms

# Install Ansible and required dependencies.
pip install ansible ansible-lint

# Lint the Cluster playbook.
ansible-lint main.yml

# Set up the Cluster containers.
docker-compose up -d

# Execute the Cluster playbook inside the controller container.
docker-compose exec controller bash -c "ansible-playbook -i inventory main.yml"
