#!/bin/bash
#
# Tests for ansible-solr-container playbook.
set -e

cd ansible-solr-container

# Install Ansible and required dependencies.
pip3 install ansible ansible-lint docker

# Lint the Ansible solr container playbook.
ansible-lint

# Install playbook dependencies.
ansible-galaxy install -r requirements.yml

# Get the current python binary in use.
export ANSIBLE_PYTHON_INTERPRETER=$(which python)

# Run the Ansible playbook.
ansible-playbook -i inventory main.yml

# Run the test playbook to verify the image works.
ansible-playbook -i inventory test.yml
