#!/bin/bash
#
# Tests for hello-ansible playbook.
set -e

cd hello-ansible

# Install Ansible and required dependencies.
pip3 install ansible ansible-lint

# Lint the Hello Ansible playbooks.
ansible-lint main.yml

# Run the Ansible playbooks.
ansible-playbook -i inventory main.yml
