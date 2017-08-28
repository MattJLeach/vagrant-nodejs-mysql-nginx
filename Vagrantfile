# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 3306, host: 33060
  config.vm.synced_folder "./", "/home/vagrant/www"
  config.vm.hostname = "vagrant.dev"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.name = "Vagrant Node"
  end
  config.vm.provision "shell", path: "./vagrant/provision.sh"
  config.vm.provision "shell", path: "./vagrant/after.sh", run: 'always'
end
