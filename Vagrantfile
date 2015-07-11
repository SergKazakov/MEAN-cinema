# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 7000, host: 7000

  config.vm.provider "virtualbox" do |vb|
    vb.name = "mean"
    vb.memory = 1024
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
  end

  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]

  config.vm.provision :shell, :path => "provision.sh"

end
