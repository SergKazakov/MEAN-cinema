# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty32"

  config.vm.network "forwarded_port", guest: 7000, host: 7000

  config.vm.provider "virtualbox" do |vb|
    vb.name = "mean"
    vb.memory = 512
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
  end

  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]

  config.vm.provision "shell", path: "provision.sh", privileged: false

end
