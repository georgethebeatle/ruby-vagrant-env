# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  
  config.vm.network "forwarded_port", guest: 4567, host: 4567
  config.vm.network "forwarded_port", guest: 9292, host: 9292

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.env_proxy.http = "http://proxy:8080"
    config.env_proxy.https = "https://proxy:8080"
    config.proxy.http     = "http://proxy:8080"
    config.proxy.https    = "https://proxy:8080"
    config.proxy.no_proxy = "localhost,127.0.0.1"  
  end

  config.vm.provision "shell", path: "provision.sh"
end

