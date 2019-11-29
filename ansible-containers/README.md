# Ansible manages containers

This folder contains examples of Ansible working to manage the container lifecycle; building, testing, and pushing containers to registries.

## Local registry playbook

The `registry.yml` playbook runs a local Docker registry, which is used in the container lifecycle playbook.

To run the playbook, make sure you have the Python Docker library installed:

    pip install docker

Then run the playbook:

    ansible-playbook -i inventory registry.yml

## Container lifecycle playbook

The `main.yml` playbook builds the hello-go app, runs and tests it, then pushes it to a local Docker registry, using Ansible's `docker_*` modules.

Then run the playbook:

    ansible-playbook -i inventory main.yml

(This playbook also requires the `docker` Python library, installable via Pip.)
