Vagrant.configure("2") do |config|
  config.vm.define "master", primary: true do |master|
    master.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 1
        v.name = 'master-k8'
      end
      master.vm.network "private_network", ip: "192.168.50.4"
      master.vm.box = "generic/ubuntu2004"
      master.vm.provision "file", source: "#{File.dirname(__FILE__)}/scripts/.bash_aliases", destination: "~/.bash_aliases"
      master.vm.synced_folder "#{File.dirname(__FILE__)}/synced", "/mnt/synced"
      master.vm.provision :shell, path: "#{File.dirname(__FILE__)}/scripts/bs-master.sh"
      master.ssh.username = "vagrant"
      master.ssh.password = "vagrant"
  end

  config.vm.define "slave1", primary: false do |slave1|
      slave1.vm.provider "virtualbox" do |v|
          v.memory = 4096
          v.cpus = 1
          v.name = 'slave1-k8'
        end
        slave1.vm.network "private_network", ip: "192.168.50.5"
        slave1.vm.box = "generic/ubuntu2004"
        slave1.vm.provision "file", source: "#{File.dirname(__FILE__)}/scripts/.bash_aliases", destination: "~/.bash_aliases"
        slave1.vm.provision :shell, path: "#{File.dirname(__FILE__)}/scripts/bs-slave.sh"
        slave1.vm.provision :shell, path: "#{File.dirname(__FILE__)}/synced/add-node.sh"
        slave1.ssh.username = "vagrant"
        slave1.ssh.password = "vagrant"
    end
end
