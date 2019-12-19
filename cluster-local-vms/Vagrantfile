# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "geerlingguy/debian10"
  config.ssh.insert_key = false
  config.vm.provider "virtualbox"
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.provider :virtualbox do |v|
    v.memory = 2048
    v.cpus = 2
    v.linked_clone = true
    v.customize ['modifyvm', :id, '--audio', 'none']
  end

  # Define three VMs with static private IP addresses.
  boxes = [
    { :name => "kube1", :ip => "192.168.7.2" },
    { :name => "kube2", :ip => "192.168.7.3" },
    { :name => "kube3", :ip => "192.168.7.4" }
  ]

  # Configure each of the VMs.
  boxes.each_with_index do |opts, index|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name] + ".cluster.test"
      config.vm.network :private_network, ip: opts[:ip]

      # Provision all the VMs using Ansible after last VM is up.
      if index == boxes.size - 1
        config.vm.provision "ansible" do |ansible|
          ansible.compatibility_mode = "2.0"
          ansible.playbook = "main.yml"
          ansible.inventory_path = "inventory"
          ansible.limit = "all"
        end
      end
    end
  end

end
