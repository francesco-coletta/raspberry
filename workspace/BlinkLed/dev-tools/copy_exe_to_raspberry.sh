#!/bin/sh


echo "#################################"
echo "copy exe to raspberry"
echo "#################################"

mkdir -p /mnt/pi/home/project/blinkled
cp ../Debug/BlinkLed /mnt/pi/home/project/blinkled
cp ../doc/blinkled.cfg /mnt/pi/home/project/blinkled
