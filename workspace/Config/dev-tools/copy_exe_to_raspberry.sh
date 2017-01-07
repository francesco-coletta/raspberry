#!/bin/sh


echo "#################################"
echo "copy exe to raspberry"
echo "#################################"

mkdir -p /mnt/pi/home/project/config
cp ../Debug/Config /mnt/pi/home/project/config
cp ../doc/config.cfg /mnt/pi/home/project/config
