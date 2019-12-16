#!/bin/bash
#
# Tests for cluster-local-vms playbook.
set -e

cd cluster-local-vms

# If on Travis CI, update Docker's configuration.
if [ "$TRAVIS" == "true" ]; then
  # Create temp dirs for overlayfs.
  mkdir -p /tmp/docker/kube1
  mkdir -p /tmp/docker/kube2
  mkdir -p /tmp/docker/kube3

  # Write a custom resolv.conf file to be mounted.
  echo 'nameserver 8.8.8.8' | sudo tee /tmp/docker/resolv.conf

  # Write Docker daemon config.
  echo '{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "storage-driver": "overlay2"
  }' | sudo tee /etc/docker/daemon.json

  # Restart Docker.
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
ansible-playbook -i inventory-docker main.yml -vv || true

# Get some debug info.
docker-compose exec kube1 bash -c "journalctl --no-pager -u kubelet"
docker-compose exec kube1 bash -c "cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf"
