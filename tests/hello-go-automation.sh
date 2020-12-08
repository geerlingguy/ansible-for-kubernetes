#!/bin/bash
#
# Tests for hello-go-automation playbook.
set -e

cd hello-go-automation

# Install kubectl.
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# Install minikube.
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube && sudo mv minikube /usr/local/bin/
sudo apt-get update
sudo apt-get install -y conntrack

# Install Ansible and required dependencies.
pip3 install ansible ansible-lint openshift

# Lint the Ansible playbooks.
ansible-lint *.yml

# Start minikube (without docker driver).
minikube start --driver=docker
minikube update-context
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}'; \
  until kubectl get nodes -o jsonpath="$JSONPATH" 2>&1 | grep -q "Ready=True"; do sleep 1; done

# Once Minikube is started, run the Ansible playbook.
ansible-playbook -i inventory main.yml

# Get the Hello Go URL from Minikube.
HELLO_GO_URL=$(minikube service hello-go --url=true)

# Test the response with curl.
if curl -s $HELLO_GO_URL | grep "Hello, you requested: /"; then
    echo "Received the correct response."
else
    echo "Did not receive the correct response."
    exit 1
fi

# Test the scale-k8s_scale.yml playbook (allow failure until Ansible 2.10).
ansible-playbook -i inventory scale-k8s_scale.yml || true

# Test the scale-strategic-merge.yml playbook.
ansible-playbook -i inventory scale-strategic-merge.yml

# Verify there are now 4 pods running.
if [ ! $(kubectl get pods -l app=hello-go --no-headers | wc -l) -eq "4" ]; then
  echo "Deployment did not scale to four Pods."
  exit 1
fi
