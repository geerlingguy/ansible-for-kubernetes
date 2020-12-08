#!/bin/bash
#
# Tests for cluster-aws-eks playbook.
set -e

cd cluster-aws-eks

# Install AWS CLI.
pip3 install awscli yamllint cfn-lint ansible-lint ansible openshift

# Export AWS vars.
export AWS_DEFAULT_REGION=us-east-1

# Validate Cloudformation templates.
echo "Validating CloudFormation templates..."
for template in cloudformation/*.yml; do
  yamllint --strict $template
  cfn-lint --include-checks I --template $template
  # validate-template requires valid AWS Credentials :(
  # aws cloudformation validate-template --template-body file://$template --region us-east-1
done

# Check ansible playbooks for correctness.
playbooks="main.yml deploy.yml delete.yml"
echo "Checking playbook syntax..."
ansible-playbook -i inventory $playbooks --syntax-check
echo "Linting playbooks with ansible-lint..."
ansible-lint $playbooks

# Install Kind.
KIND_VERSION="v0.9.0"
sudo curl -Lo /usr/local/bin/kind https://github.com/kubernetes-sigs/kind/releases/download/"${KIND_VERSION}"/kind-linux-amd64
sudo chmod +x /usr/local/bin/kind

# Install kubectl.
sudo curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl

# Prepare a Kind cluster.
export KUBECONFIG="${HOME}/.kube/kind-config-test"
kind create cluster --name=test --quiet

# Test WordPress manifests in Kind cluster.
ANSIBLE_PYTHON_INTERPRETER=$(which python3) \
ansible-playbook -i inventory deploy.yml \
  -e "k8s_kubeconfig=$KUBECONFIG" \
  -e "aws_environment=false" \
  -e "k8s_no_log=false"

# Verify WordPress service is present.
kubectl get service wordpress
