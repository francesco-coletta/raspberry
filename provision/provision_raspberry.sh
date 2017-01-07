#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive

echo ">>>> Update system ..."
#echo "IMP: riattivare"
sudo apt-get -q update #&& sudo apt-get -y -q upgrade
echo -e "done\n"


echo ">>>> Install Requirements and Dependencies for raspberry cross-compiler ..."
echo "TODO: RIATTIVARE"
#sudo apt-get install -y -q rsync cmake ia32-libs build-essential g++
echo -e "done\n"

echo ">>>> Clone raspberry cross-compiler ..."
cd /tmp
echo "TODO: RIATTIVARE"
#git clone https://github.com/raspberrypi/tools.git
echo -e "done\n"

DEV_FOLDER=/usr/local/dev
CROSSCOMPILER_FOLDER=${DEV_FOLDER}/tools/arm-bcm2708
echo ">>>> Create folder ${DEV_FOLDER}..."
echo "TODO: RIATTIVARE"
#sudo mkdir -p ${DEV_FOLDER}
echo -e "done\n"

echo ">>>> Copy raspberry cross-compiler into folder ${DEV_FOLDER} ..."
echo "TODO: RIATTIVARE"
#cp -R /tmp/tools ${DEV_FOLDER}
#cd ${CROSSCOMPILER_FOLDER}
#rm -Rf arm*
#rm -Rf gcc-linaro-arm-linux-gnueabihf-raspbian
echo -e "done\n"

echo ">>>> Change permission ..."
sudo chown -R vagrant:vagrant ${DEV_FOLDER}
echo -e "done\n"

echo ">>>> Install NFS client tool ..."
sudo apt-get install nfs-common -y
echo -e "done\n"

echo ">>>> Command to run on Raspi for configure NFS server ..."
#echo "On Raspi must run e NFS server (http://www.instructables.com/id/Turn-Raspberry-Pi-into-a-Network-File-System-versi/?ALLSTEPS):"
echo "On Raspi must run e NFS server (http://www.htpcguides.com/configure-nfs-server-and-nfs-client-raspberry-pi/, https://mauriziosiagri.wordpress.com/tag/nfs-kernel-server/, http://blog.shahada.abubakar.net/post/raspberry-pi-software-development-with-a-cross-compiler):"
echo "Step 1: Install NFS"
echo "sudo apt-get update"
echo "sudo apt-get upgrade"
echo "sudo apt-get dist-upgrade"
echo "sudo apt-get install -y nfs-common rpcbind nfs-kernel-server"
echo "Step 2: Share a directory"
echo "sudo mkdir -p /srv/nfs/share"
echo "sudo chmod -R 777 /srv/nfs/share"
echo "cd /srv/nfs/share"
echo "sudo touch hello.txt"
echo "sudo chmod -R 777 /srv/nfs/share"
echo "sudo echo \"Hello NFS\" > hello.txt"
echo "sudo echo \"/srv/nfs/share                      *(rw,sync,no_subtree_check)\" | sudo tee -a /etc/exports"
echo "sudo echo \"/home/pi               192.168.1.0/24(rw,sync,no_subtree_check,insecure,fsid=1)\" | sudo tee -a /etc/exports"
echo "sudo echo \"/                      192.168.1.0/24(ro,sync,no_subtree_check,insecure,fsid=2)\" | sudo tee -a /etc/exports"
echo "sudo exportfs -ra"
echo "sudo update-rc.d rpcbind enable"
echo "sudo service nfs-kernel-server restart"
echo "sudo service rpcbind restart"
echo ""
echo -e "done\n"


MNT_RASPI_FOLDER=/mnt/pi
echo ">>>> Create folder for mount Raspberry home and root ..."
echo "TODO: RIATTIVARE"
#sudo mkdir -p ${MNT_RASPI_FOLDER}/home
#sudo mkdir -p ${MNT_RASPI_FOLDER}/root
#sudo chown -R vagrant:vagrant ${MNT_RASPI_FOLDER}
echo -e "done\n"

echo ">>>> Mount ..."
#sudo mount -t nfs 192.168.1.2:/media/VM /mnt/VM
echo "TODO: RIATTIVARE"
#sudo echo "192.168.1.112:/home/pi  /mnt/pi/home   nfs    noexec,rw 0 0" | sudo tee -a /etc/fstab
#sudo echo "192.168.1.112:/  /mnt/pi/root   nfs    noexec,rw 0 0" | sudo tee -a /etc/fstab
#sudo mount /mnt/pi/home
#sudo mount /mnt/pi/root
echo -e "done\n"

echo ">>>> Create symbolic link to remote Raspi FS ..."
sudo ln -s /mnt/pi/root/usr/lib/arm-linux-gnueabihf /usr/lib/arm-linux-gnueabihf 
sudo ln -s /mnt/pi/root/lib/arm-linux-gnueabihf /lib/arm-linux-gnueabihf 
echo -e "done\n"



HOME=/home/vagrant
#PROFILE=${HOME}/.zprofile
PROFILE=${HOME}/.zshrc
echo ">>>> Configure PATH and user profile ..."
echo " " >> ${PROFILE}
echo "#------------------------------------------" >> ${PROFILE}
echo "#"$(date '+%Y-%m-%d %H:%M:%S') >> ${PROFILE}
PATH_01="PATH=${PATH}:"${CROSSCOMPILER_FOLDER}/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/
echo ${PATH_01} >> ${PROFILE}

PATH_02="RASPI_TOOLS_DIR="${CROSSCOMPILER_FOLDER}/gcc-linaro-arm-linux-gnueabihf-raspbian-x64
echo ${PATH_02} >> ${PROFILE}
echo "export RASPI_TOOLS_DIR" >> ${PROFILE}
echo "export PATH" >> ${PROFILE}
source ${PROFILE}

sudo chown -R vagrant:vagrant ${PROFILE}

echo -e "done\n"



