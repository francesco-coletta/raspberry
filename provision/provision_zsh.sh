#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive
echo ">>>> Update system ..."
#sudo apt-get -q update && sudo apt-get -y -q upgrade
echo -e "skipped\n"
echo -e "done\n"

# Utility
echo ">>>> Installing shell zsh ..."
sudo apt-get -y -q install zsh 
echo -e "done\n"

# Install oh-my-zsh
echo ">>>> Install oh-my-zsh ..."
if [ ! -d ~vagrant/.oh-my-zsh ]; then
	sudo -u vagrant sh -sc "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
echo -e "done\n"


echo ">>>> Configure zsh for vagrant user ..."
cd /tmp
sudo rm -rf dotfiles
git clone https://github.com/francesco-coletta/dotfiles.git
cd dotfiles
sudo git pull
sudo git checkout vagrant
sudo cp zsh/zshrc ~vagrant/.zshrc && chown vagrant: "$_"
##sudo mkdir -p /home/vagrant/.oh-my-zsh/themes && sudo cp zsh/coletta.zsh-theme "$_"
#sudo cp zsh/coletta.zsh-theme ~vagrant/.oh-my-zsh/themes
#sudo chown vagrant: ~vagrant/.oh-my-zsh/themes/coletta.zsh-theme


echo "Set zsh as default shel for vagrant user"
sudo chsh -s /bin/zsh vagrant
echo -e "done\n"

