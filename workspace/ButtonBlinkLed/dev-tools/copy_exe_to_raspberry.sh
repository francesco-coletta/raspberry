#!/bin/sh


echo "#################################"
echo "copy exe to raspberry"
echo "#################################"

mkdir -p /mnt/pi/home/project/buttonblinkled
cp ../Debug/ButtonBlinkLed /mnt/pi/home/project/buttonblinkled
cp ../doc/buttonblinkled.cfg /mnt/pi/home/project/buttonblinkled
