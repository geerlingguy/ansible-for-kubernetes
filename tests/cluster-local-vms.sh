#!/bin/bash
#
# Tests for cluster-local-vms playbook.
set -e

cd cluster-local-vms

# If on Travis CI, update Docker's configuration.
if [ "$TRAVIS" == "true" ]; then
  mkdir -p /tmp/docker/kube1
  mkdir -p /tmp/docker/kube2
  mkdir -p /tmp/docker/kube3
  echo '{
    "experimental": true,
    "storage-driver": "overlay2",
    "dns": ["1.1.1.1", "1.0.0.1"]
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
ansible-playbook -i inventory-docker main.yml || true

# Get some debug info.
docker-compose exec kube1 bash -c "systemctl status docker.service --no-pager --full"
docker-compose exec kube2 bash -c "systemctl status docker.service --no-pager --full"
docker-compose exec kube1 bash -c "journalctl --no-pager -u docker"
docker-compose exec kube2 bash -c "journalctl --no-pager -u docker"
docker-compose exec kube1 bash -c "journalctl --no-pager -u kubelet"
