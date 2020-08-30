# Testing with Molecule, Kind, and Ansible

This directory contains a Molecule-based test environment which allows development and testing of Ansible playbooks against a [Kind](https://kind.sigs.k8s.io/) Kubernetes cluster.

## Installing Prerequisites

Before running the environment, you need to make sure [Molecule](https://molecule.readthedocs.io/en/latest/), [Kind](https://kind.sigs.k8s.io), and [Docker](https://www.docker.com/products/docker-desktop) are installed:

  1. `brew install kind docker` (assuming macOS)
  1. `pip3 install molecule ansible-test yamllint`

## Running tests

You can run the full default test scenario using Molecule:

    molecule test

This scenario does the following:

  1. Builds a test Kind cluster.
  2. Runs the `molecule/default/converge.yml` playbook against the cluster.
  3. Runs the playbook again to test idempotence.
  4. Destroys the test Kind cluster.

You can also build the cluster and leave it running with:

    molecule converge

After you're finished, tear down the development cluster with:

    molecule destroy
