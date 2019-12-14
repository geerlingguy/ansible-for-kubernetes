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
which docker
docker-compose up -d

# Install Docker inside the controller container.
docker-compose exec controller bash -c "\
  apt update && \
  apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
  apt update && \
  apt install -y docker-ce"

# Execute the Cluster playbook inside the controller container.
docker-compose exec controller bash -c "cd /opt/ansible && ansible-galaxy install -r requirements.yml"
docker-compose exec controller bash -c "cd /opt/ansible && ansible-playbook -i inventory main.yml"
