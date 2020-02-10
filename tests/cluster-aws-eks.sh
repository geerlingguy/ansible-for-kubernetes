#!/bin/bash
#
# Tests for cluster-aws-eks playbook.
set -e

cd cluster-aws-eks

# Install AWS CLI.
travis_fold start "install.pip.deps"
pip3 install awscli yamllint cfn-lint ansible-lint ansible openshift
travis_fold end "install.pip.deps"

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

# Prepare a Kind cluster.
travis_fold start "prepare.kind.cluster"
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
curl -Lo kind https://github.com/kubernetes-sigs/kind/releases/download/v0.6.1/kind-linux-amd64
chmod +x kind
sudo mv kind /usr/local/bin/
export KUBECONFIG="${HOME}/.kube/kind-config-test"
kind create cluster --name=test --quiet
travis_fold end "prepare.kind.cluster"

# Test WordPress manifests in Kind cluster.
ANSIBLE_PYTHON_INTERPRETER=$(which python3) \
ansible-playbook -i inventory deploy.yml \
  -e "k8s_kubeconfig=$KUBECONFIG" \
  -e "aws_environment=false" \
  -e "k8s_no_log=false"

# Verify WordPress service is present.
kubectl get service wordpress
