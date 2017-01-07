#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive

echo ">>>> Update system ..."
#sudo apt-get -q update && sudo apt-get -y -q upgrade
echo -e "done\n"

# Editors
echo ">>>> Installing editors VIM ..."
sudo apt-get install -y -q vim
echo -e "done\n"

echo ">>>> Installing editors gedit ..."
sudo apt-get install -y -q gedit
echo -e "done\n"

echo ">>>> Installing editors geany ..."
sudo apt-get install -y -q geany geany-plugins
sudo mkdir -p /home/vagrant/.config/geany/colorschemes/
cd /tmp
git clone https://github.com/geany/geany-themes.git
cd geany-themes/colorschemes
cp * /home/vagrant/.config/geany/colorschemes/
sudo chown -R vagrant:vagrant /home/vagrant/.config/geany
echo -e "done\n"



echo ">>>> Installing editors Eclipse CDT ..."
sudo wget -O /opt/eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz --progress=bar:force:noscroll --show-progress --quiet http://ftp.fau.de/eclipse/technology/epp/downloads/release/neon/2/eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz

#sudo wget -O /opt/eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz --progress=bar:force:noscroll --show-progress --quiet  https://www.dropbox.com/s/7g2m341mtognuer/manuale%20karate.pdf.pdf?dl=0

cd /opt/ && sudo tar -zxvf eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz

cd /home/vagrant/Desktop
rm -f /home/vagrant/Desktop/eclipse
sudo -u vagrant ln -s /opt/eclipse/eclipse eclipse

echo -e "done\n"

