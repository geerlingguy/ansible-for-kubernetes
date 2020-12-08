#!/bin/bash
#
# Tests for testing-molecule-kind playbook.
set -e

cd testing-molecule-kind

# Install Ansible and required dependencies.
pip3 install ansible ansible-lint molecule openshift

# Install Kind.
KIND_VERSION="v0.9.0"
sudo curl -Lo /usr/local/bin/kind https://github.com/kubernetes-sigs/kind/releases/download/"${KIND_VERSION}"/kind-linux-amd64
sudo chmod +x /usr/local/bin/kind

# Install kubectl.
sudo curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl

# Test with Molecule.
molecule test
