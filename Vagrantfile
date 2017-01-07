#-*- mode: ruby -*-
# vi: set ft=ruby :

# Insert list of plugins to install separated from blanck
required_plugins = %w(vagrant-vbguest vagrant-gatling-rsync)

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

VAGRANTFILE_API_VERSION = "2"
ENV["VAGRANT_DEFAULT_PROVIDER"] = "virtualbox"
BOX = "debian/jessie64"
BOX_VERSION = "8.6.1"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = BOX
  config.vm.box_version = BOX_VERSION

  config.vm.hostname = "raspberry"
  config.vm.define "raspberry"
  
  config.ssh.forward_x11 = true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 3000, host: 3000


  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # define here the IP address on which the VM will be accessible to the Vagrant Host machine
  config.vm.network "private_network", ip: "10.10.10.29"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/home/vagrant/ws", create: true, disabled: false

  # Configure the window for gatling to coalesce writes.
  if Vagrant.has_plugin?("vagrant-gatling-rsync")
    config.gatling.latency = 2.0
    config.gatling.time_format = "%H:%M:%S"

    # Automatically sync when machines with rsync folders come up.
    config.gatling.rsync_on_startup = false
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider "virtualbox" do |vb|
      vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional'] 
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--usb", "on"]
      #vb.customize ["modifyvm", :id, "--usbehci", "on"]
      vb.customize ["modifyvm", :id, "--vram", "128"]
      vb.customize ["modifyvm", :id, "--monitorcount", "2"]
      vb.name = "raspberry"
      vb.memory = 4096
      vb.gui = true
      vb.cpus= 2
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  
  # 1
  config.vm.provision "shell", inline: <<-SHELL
    echo " "
    echo "==================================================="
    echo "PROVISIONING 1/5: GENERAL"
    echo "==================================================="
  SHELL
  #config.vm.provision "shell", path: "./provision/provision_general.sh"
  
  # 2
  config.vm.provision "shell", inline: <<-SHELL
    echo " "  
    echo "==================================================="
    echo "= PROVISIONING 2/5: Shel zsh"
    echo "==================================================="
  SHELL
  #config.vm.provision "shell", path: "./provision/provision_zsh.sh"  
  
  # 3
  config.vm.provision "shell", inline: <<-SHELL
    echo " "  
    echo "==================================================="
    echo "= PROVISIONING 3/5: Desktop Manager XFCE4"
    echo "==================================================="
  SHELL
  #config.vm.provision "shell", path: "./provision/provision_desktopManager.sh" 

  # 4
  config.vm.provision "shell", inline: <<-SHELL
    echo " "  
    echo "==================================================="
    echo "= PROVISIONING 4/5: Development (Vim, Eclipse, Java)"
    echo "==================================================="
  SHELL
  #config.vm.provision "shell", path: "./provision/provision_java.sh"
  #config.vm.provision "shell", path: "./provision/provision_dev.sh" 

  # 5
  config.vm.provision "shell", inline: <<-SHELL
    echo " "  
    echo "==================================================="
    echo "= PROVISIONING 5/5: Raspberry Environment Development (Toolchain crosscompile)"
    echo "==================================================="
  SHELL
  config.vm.provision "shell", path: "./provision/provision_raspberry.sh"
  

end
