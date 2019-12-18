# Local Kubernetes Cluster Example

This example demonstrates the setup of a single-master, multi-node Kubernetes cluster, running locally in three VMs. You can run the Ansible playbook against any three servers, but this example includes a Vagrantfile, which allows Vagrant to automatically build three VirtualBox VMs and then runs the playbook agains them automatically.

## Usage

Before building the cluster, you need to install the following:

  1. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
  2. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  3. [Vagrant](https://www.vagrantup.com/downloads.html)

Then, in this directory, run:

    $ ansible-galaxy install -r requirements.yml
    $ vagrant up

After a few minutes, the three VMs will be booted, and the Ansible playbook will have installed Kubernetes using the `main.yml` playbook.

## Managing Kubernetes

You can log into the master node with the command:

    $ vagrant ssh kube1

From there, run `sudo su` to switch to the root user, and then you can use `kubectl` to manage the Kubernetes cluster.

## Running the `test-deployment.yml` playbook

You can run a playbook to run a test deployment and service in the cluster, and verify they are working correctly:

    $ ansible-playbook -i inventory test-deployment.yml
