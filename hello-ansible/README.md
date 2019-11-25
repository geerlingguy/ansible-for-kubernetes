# Hello, Ansible example

The playbook in this directory is an extremely simple and straightforward Ansible playbook. It introduce the book's reader to the basic concepts of Ansible.

It is all configured to be run against `localhost` using a `local` connection, and can be run with the following command:

    ansible-playbook -i inventory main.yml

This assumes you've already [installed Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
