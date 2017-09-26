ENV["LC_ALL"] = "en_GB.UTF-8"
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |v|
    v.name = "vault-host"
    v.memory = 2048
    v.cpus = 1
  end
  config.vm.network "private_network", ip: "192.168.56.103"
  config.ssh.forward_agent = true
  config.vm.hostname = "vault-host"
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: ".ssh/authorized_keys"
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.raw_arguments = "--private-key=~/.ssh/id_rsa"
    ansible.playbook = "site.yml"
    ansible.inventory_path = "hosts"
    ansible.sudo = true
    ansible.host_key_checking = false
    ansible.limit = "192.168.56.103"
    ansible.groups = {
      "default"   =>  ["192.168.56.103"]
    }
  end
end
