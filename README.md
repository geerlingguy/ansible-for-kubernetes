# Ansible for Kubernetes Examples

[![CI](https://github.com/geerlingguy/ansible-for-kubernetes/workflows/CI/badge.svg?event=push)](https://github.com/geerlingguy/ansible-for-kubernetes/actions?query=workflow%3ACI) [![Molecule Kind Test](https://github.com/geerlingguy/ansible-for-kubernetes/workflows/Molecule%20Kind%20Test/badge.svg?branch=master)](https://github.com/geerlingguy/ansible-for-kubernetes/actions?query=workflow%3A%22Molecule+Kind+Test%22)

This repository contains Ansible and Kubernetes examples developed to support different sections of [Ansible for Kubernetes](https://www.ansibleforkubernetes.com/) by [Jeff Geerling](https://www.jeffgeerling.com/).

Not all playbooks follow all of Ansible and Kubernetes' best practices, as they illustrate particular features in an instructive manner.

## Examples and Chapters in which they're used

Here is an outline of all the examples contained in this repository, by chapter:

### Chapter 1

  - [`hello-go`](hello-go/): A basic 'hello, world!' application written in the Go language, used to demonstrate running a very simple stateless app in a container in a Kubernetes cluster.

### Chapter 2

  - [`hello-ansible`](hello-ansible/): A basic Ansible playbook, meant to introduce someone completely new to Ansible to task-based automation.
  - [`hello-go-automation`](hello-go-automation/): A fully-automated example of all the manual commands used to build and run the Hello Go app from Chapter 1 in a local Kubernetes cluster.

### Chapter 3

  - [`ansible-containers`](ansible-containers/): An Ansible-driven way of building a container image for the Hello Go app.
  - [`ansible-solr-container`](ansible-solr-container/): An end-to-end playbook for building an Apache Solr container image and testing it using Ansible's Docker connection plugin, without using a Dockerfile.

### Chapter 4

  - [`cluster-local-vms`](cluster-local-vms/): A Kubernetes cluster running on three local VirtualBox VMs, built with Vagrant and Ansible.

### Chapter 5

  - [`cluster-aws-eks`](cluster-aws-eks/): An AWS EKS Cluster with an EKS Node Group, which uses Ansible to apply CloudFormation templates that set up stacks for a VPC and networking, an EKS Cluster, and an associated EKS Node Group.

### Chapter 6

  - N/A

### Chapter 7

  - [`testing-molecule-kind`](testing-molecule-kind/): A Molecule-based test environment which allows development and testing of Ansible playbooks against a Kind Kubernetes cluster.

## License

MIT

## Buy the Book

[![Ansible for Kubernetes Cover](https://s3.amazonaws.com/titlepages.leanpub.com/ansible-for-kubernetes/medium)](https://www.ansibleforkubernetes.com/)

Buy [Ansible for Kubernetes](https://www.ansibleforkubernetes.com/) for your e-reader or in paperback format.
