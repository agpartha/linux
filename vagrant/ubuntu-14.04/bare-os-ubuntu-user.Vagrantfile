ENV['VBOX_INSTALL_PATH'] = ENV['VBOX_MSI_INSTALL_PATH']
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

VM_IMAGE_URL  = 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box'
VM_IMAGE_NAME = 'phusion-ubuntu-14.04'

USERNAME      = ENV['USER']
PUBKEY        = File.read(File.expand_path '~/.ssh/id_rsa.pub')

# The following lines will provision the proj VM
# assuming chef is set-up.
#
# knife solo prepare proj.local
# knife solo cook proj.local nodes/proj.local.json

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "proj"

  config.vm.provider :virtualbox do |driver, override|
    driver.gui = false

    driver.customize ['modifyvm', :id, '--cpus'        , 2    ]
    driver.customize ['modifyvm', :id, '--memory'      , 2048 ]
    driver.customize ['modifyvm', :id, '--natdnsproxy1', 'on' ]
    # see https://github.com/mitchellh/vagrant/issues/7648
    driver.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end

  config.vm.define :proj do |node|
    node.vm.box      = VM_IMAGE_NAME
    node.vm.box_url  = VM_IMAGE_URL
    node.vm.hostname = 'proj'
    node.vm.network    :private_network, ip: "33.23.23.33"
#    node.vm.network    :private_network, type: "dhcp"
#	node.vm.network "forwarded_port", guest: 22, host: 3322, protocol: "tcp", auto_correct: true, id: 'ssh'
#	node.vm.network "forwarded_port", guest: 22, host: 3322, protocol: "udp", auto_correct: true, id: 'ssh'

    node.vm.provider :virtualbox do |diver, override|
      diver.name = 'proj'
    end

    node.vm.provision :shell, inline: <<-SCRIPT
      sudo apt-get update
      sudo  DEBIAN_FRONTEND=noninteractive apt-get install -y avahi-daemon libnss-mdns
      cd /etc/avahi

      if ! [ `egrep -q "^enable-dbus=no" avahi-daemon.conf` ]; then
        sed -i "s/^#enable-dbus=yes/enable-dbus=no/g" avahi-daemon.conf
      fi

      useradd #{ USERNAME } -m -p '' -c '' -G sudo -s /bin/bash && echo "Added user #{ USERNAME }..."
      mkdir /home/#{ USERNAME }/.ssh && echo "Made '.ssh' for #{ USERNAME }..."
      echo "#{ PUBKEY }" >> /home/#{ USERNAME }/.ssh/authorized_keys && echo "Added authorized key for #{ USERNAME }. Key was: '#{ PUBKEY }'"

      echo #{USERNAME} ALL=NOPASSWD:ALL > /etc/sudoers.d/${USERNAME}
      chmod 0440 /etc/sudoers.d/${USERNAME}

      modprobe -a vboxguest vboxsf vboxvideo
    SCRIPT

    node.vm.synced_folder "../", "/opt/mount", {
      :id        => 'proj-mount',
      :disabled  => false,
      :group     => 'vagrant',
      :owner     => 'vagrant'
    }
  end
end
