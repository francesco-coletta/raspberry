#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive
echo ">>>> Update system ..."
#sudo apt-get -q update && sudo apt-get -y -q upgrade
echo -e "skipped\n"
echo -e "done\n"

echo ">>>> Installing Desktop manager xfce4"
sudo apt-get -y -q install xfce4 
sudo apt-get install gnome-icon-theme-full tango-icon-theme
echo -e "done\n"

echo ">>>> Permit anyone to start the GUI"
sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
echo -e "done\n"


# Configure for start xfce4 on boot
echo ">>>> Configure for start xfce4 on boot ..."
HOME=/home/vagrant
XINITRC=${HOME}/.xinitrc

sudo apt-get install -y -q slim
sudo systemctl enable slim
sudo touch ${XINITRC}
cat /dev/null > ${XINITRC}
echo "#!/bin/sh" | sudo tee -a ${XINITRC}
echo "# Executed by startx (run your window manager from here)" | sudo tee -a ${XINITRC}
echo "exec startxfce4" | sudo tee -a ${XINITRC}

sudo echo "login_cmd           exec /bin/zsh -l ~/.xinitrc %session" | sudo tee -a /etc/slim.conf
sudo chown -R vagrant:vagrant ${XINITRC}
sudo chmod +x ${XINITRC}
echo -e "done\n"

