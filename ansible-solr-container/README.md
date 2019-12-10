# Ansible Apache Solr Container Example

Most people build containers using a `Dockerfile`, but it's easy (and sometimes much more manageable) to build containers other ways.

In this example, Ansible is used to:

  1. Start a container.
  2. Run Ansible roles to install Java and Apache Solr on the container.
  3. Commit the container image.
  4. Stop and remove the container.

Effectively the same as using a `Dockerfile` and `docker build`, but built using Ansible's automation engine, which offers more flexibility for advanced use cases, or supporting numerous different base images and distributions—or for supporting an application build on both legacy servers and inside containers, with shared automation and configuration code.

> If you want a maintained Apache Solr container to use in your infrastructure, I recommend using the [`geerlingguy/solr` image](https://hub.docker.com/r/geerlingguy/solr/), available on Docker Hub. It is built [using a similar playbook](https://github.com/geerlingguy/solr-container), but is available to pull from anywhere, and has tags available for many Solr versions.

## Usage

This playbook assumes you have Docker CE, Ansible (`pip[3] install ansible`), and the Docker Python library installed (`pip[3] install docker`).

### Building the Container

In this playbook directory, install dependencies from Ansible Galaxy:

    ansible-galaxy install -r requirements.yml

Run the playbook to build the Apache Solr container image:

    ansible-playbook -i inventory main.yml

### Testing the Container

A `test.yml` playbook is included which runs a container with the image the `main.yml` built, then verifies Solr starts and runs correctly, then stops and removes the container. To run the test playbook:

    ansible-playbook -i inventory test.yml
