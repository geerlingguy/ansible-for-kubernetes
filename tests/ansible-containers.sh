#!/bin/bash
#
# Tests for ansible-containers playbooks.
set -e

cd ansible-containers

# Install Ansible and required dependencies.
pip install ansible ansible-lint docker

# Lint the Ansible container playbooks.
ansible-lint *.yml

# Run the Ansible playbooks.
ansible-playbook -i inventory registry.yml
ansible-playbook -i inventory main.yml
