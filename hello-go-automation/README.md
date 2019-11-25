# Automation for the Hello World Go app

This folder contains the Ansible playbook used to automate all the manual steps in building and deploying the example [Hello Go app](../hello-go) located elsewhere in this repository.

## Usage

The Ansible playbook assumes you have the following installed on your workstation:

  - [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
  - [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

You will also need to install a Python dependencies via Python Pip:

    pip3 install openshift

Once they are installed, you can run the playbook with:

    ansible-playbook -i inventory main.yml

Once you're finished testing the Hello Go app in the Kubernetes cluster, you can clean it up by deleting the entire Minikube cluster with `minikube delete`, or you can run the following commands to delete just the necessary resources and leave the Minikube cluster running:

    kubectl delete service hello-go
    kubectl delete deployment hello-go

The above commands assume you have `kubectl` installed.

### Scaling playbooks

There are two playbooks used to demonstrate scaling resources with Ansible:

  1. `scale-k8s_scale.yml`: Scales the hello-go deployment using Ansible's `k8s_scale` module.
  2. `scale-strategic-merge.yml`: Scales the hello-go deployment using Ansible's `k8s` module and the `strategic-merge` merge strategy.

Run the playbooks with:

    ansible-playbook -i inventory scale-[type].yml
