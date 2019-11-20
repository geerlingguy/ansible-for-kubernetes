#!/bin/bash
#
# Tests for hello-go-automation playbook.
set -e

cd hello-go-automation

export CHANGE_MINIKUBE_NONE_USER=true
export K8s_VERSION="v1.16.2"

# Install kubectl.
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# Install minikube.
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube && sudo mv minikube /usr/local/bin/

# Install Ansible.
sudo apt-get install -y python-pip
pip install ansible openshift --user

# Start minikube (without the VM driver).
sudo minikube start --vm-driver=none
minikube update-context
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}'; \
  until kubectl get nodes -o jsonpath="$JSONPATH" 2>&1 | grep -q "Ready=True"; do sleep 1; done

# Once Minikube is started, run the Ansible playbook.
ansible-playbook main.yml

# Get the Hello Go URL from Minikube.
HELLO_GO_URL=$(minikube service hello-go --url=true)

# Test the response with curl.
if curl -s $HELLO_GO_URL | grep "Hello, you requested: /"; then
    echo "Received the correct response."
else
    echo "Did not receive the correct response."
    exit 1
fi
