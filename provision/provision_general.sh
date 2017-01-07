#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive

echo ">>>> Update system ..."
sudo apt-get -q update && sudo apt-get -y -q upgrade
echo -e "done\n"


# Utility
echo ">>>> Installing utility tools ..."
sudo apt-get -y -q install sudo
echo -e "done\n"

# Ssh
echo ">>>> Installing ssh tools ..."
#sudo apt-get install -y -q openssh-server
echo -e "done\n"

# Network
echo ">>>> Installing network tools ..."
#sudo apt-get install -y curl wget net-tools netcat tcdump
sudo apt-get install -y -q curl wget
echo -e "done\n"

# Create workspace folder 
WS=/home/vagrant/ws
echo ">>>> Create workspace folder ${WS}..."
sudo mkdir -p ${WS}
sudo chown vagrant:vagrant ${WS}
echo -e "done\n"

# Ssh
echo ">>>> Installing Ssh ..."
sudo apt-get install -y -q chromium
echo -e "done\n"

# Set keyboards layout
echo ">>>> Set keyboards layout ..."
sed -ie '/^XKBLAYOUT=/s/".*"/"it"/' /etc/default/keyboard && udevadm trigger --subsystem-match=input --action=change
echo -e "done\n"

# Set locale it_IT.UTF-8
echo ">>>> Set locale ..."
sudo echo "LANG=en_US.UTF-8" >> /etc/environment
sudo echo "LANGUAGE=en_US.UTF-8" >> /etc/environment
sudo echo "LC_ALL=en_US.UTF-8" >> /etc/environment
sudo echo "LC_CTYPE=en_US.UTF-8" >> /etc/environment
echo -e "done\n"

# fonts-inconsolata
echo ">>>> Installing fonts-inconsolata ..."
sudo apt-get install -y -q fonts-inconsolata
echo -e "done\n"

# Terminator (terminal)
echo ">>>> Installing terminal terminator ..."
sudo apt-get install -y -q terminator
echo -e "done\n"

# Tmux (terminal)
echo ">>>> Installing terminal tmux ..."
sudo apt-get install -y -q tmux
echo -e "done\n"


# Version control 
echo ">>>> Installing version control tools ..."
sudo apt-get install -y -q git git-review
echo '[color]
	ui = true
[color "branch"]
	current = yellow bold
	local = green bold
	remote = cyan bold
[color "diff"]
	meta = yellow bold
	frag = magenta bold
	old = red bold
	new = green bold
	whitespace = red reverse
[color "status"]
	added = green bold
	changed = yellow bold
	untracked = red bold
' > /etc/gitconfig
cd /vagrant 
git config branch.master.rebase true
cd /tmp
echo -e "done\n"
