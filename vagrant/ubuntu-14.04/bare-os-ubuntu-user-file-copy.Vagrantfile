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
    driver.customize ['modifyvm', :id, '--memory'      , 1024 ]
    driver.customize ['modifyvm', :id, '--natdnsproxy1', 'on' ]
    # see https://github.com/mitchellh/vagrant/issues/7648
    driver.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end

  config.vm.define :proj do |node|
    node.vm.box      = VM_IMAGE_NAME
    node.vm.box_url  = VM_IMAGE_URL
    node.vm.hostname = 'proj'
    node.vm.network    :private_network, ip: "33.23.23.43"

    node.vm.provider :virtualbox do |diver, override|
      diver.name = 'proj'
    end

    node.vm.provision "fix-no-tty", type: "shell" do |s|
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
    end

    node.vm.provision :shell, inline: <<-SCRIPT
	  # Update os and packages to latest
      sudo DEBIAN_FRONTEND=noninteractive apt-get -y update; sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade;sudo DEBIAN_FRONTEND=noninteractive apt clean;sudo DEBIAN_FRONTEND=noninteractive apt-get -y autoclean;sudo DEBIAN_FRONTEND=noninteractive apt-get -y remove; sudo DEBIAN_FRONTEND=noninteractive apt-get -y autoremove
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y avahi-daemon libnss-mdns
	  sudo DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential
	  sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git
      cd /etc/avahi

      if ! [ `egrep -q "^enable-dbus=no" avahi-daemon.conf` ]; then
        sed -i "s/^#enable-dbus=yes/enable-dbus=no/g" avahi-daemon.conf
      fi

	  # Add the ubuntu user, allow group writes to all $USER to copy files into it.
	  useradd ubuntu -m -p '' -c '' -G sudo -s /bin/bash -p $(openssl passwd -1 a1s200) && echo "Added user ubuntu.."
      echo ubuntu ALL=NOPASSWD:ALL > /etc/sudoers.d/ubuntu
      chmod 0440 /etc/sudoers.d/ubuntu
	  chmod a+w /home/ubuntu

      # Add $USER
      useradd #{ USERNAME } -m -p '' -c '' -G sudo -s /bin/bash && echo "Added user #{ USERNAME }..."
      mkdir /home/#{ USERNAME }/.ssh && echo "Made '.ssh' for #{ USERNAME }..."
      echo "#{ PUBKEY }" >> /home/#{ USERNAME }/.ssh/authorized_keys && echo "Added authorized key for #{ USERNAME }. Key was: '#{ PUBKEY }'"
      echo #{USERNAME} ALL=NOPASSWD:ALL > /etc/sudoers.d/${USERNAME}
      chmod 0440 /etc/sudoers.d/${USERNAME}

      # Add $USER to the ubuntu group to allow easy file operations
	  usermod -a -G ubuntu #{ USERNAME }

    SCRIPT

    # Copy the base ISO for the connector
    # For now it is copied from the repo, if we can get it from S3 easily change it to that to avoid having the ISO in the repo.
    # Copy the github keys to known hosts
    # node.vm.provision "file", source: "./proj/ubuntu-14.04.5-server-amd64.iso", destination: "/home/ubuntu/ubuntu-14.04.5-server-amd64.iso"
    node.vm.provision "file", source: "./proj/proj-setup.sh", destination: "/home/ubuntu/setup"
    node.vm.provision "file", source: "./proj/proj-build.sh", destination: "/home/ubuntu/build"
    node.vm.provision "file", source: "~/.ssh/known_hosts", destination: "/home/ubuntu/.ssh/known_hosts"
    node.vm.provision "shell", inline: <<-ISOSCRIPT
		chown ubuntu:ubuntu -R /home/ubuntu
		# Setup the one time run of ssh key generation for git access
		sudo su -c "/home/ubuntu/setup" ubuntu
	ISOSCRIPT

    node.vm.synced_folder "../", "/opt/mount", {
      :id        => 'proj-mount',
      :disabled  => false,
      :group     => 'vagrant',
      :owner     => 'vagrant'
    }
  end
end
