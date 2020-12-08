#!/bin/bash
#
# Tests for ansible-containers playbooks.
set -e

cd ansible-containers

# Install Ansible and required dependencies.
pip3 install ansible ansible-lint docker

# Lint the Ansible container playbooks.
ansible-lint *.yml

# Run the Ansible playbooks.
ansible-playbook -i inventory registry.yml -e "{ansible_python_interpreter: '{{ ansible_playbook_python }}'}"
ansible-playbook -i inventory main.yml -e "{ansible_python_interpreter: '{{ ansible_playbook_python }}'}"
