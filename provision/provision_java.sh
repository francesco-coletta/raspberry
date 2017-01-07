#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive

echo ">>>> Update system ..."
sudo apt-get -q update
echo -e "done\n"

# OpenJDK
#echo ">>>> Installing OpenJDK tools ..."
#sudo echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
#sudo apt-get install -y -q openjdk-7-jdk maven
#echo -e "done\n"

# JDK 8 from Oracle
# ref: https://www.mkyong.com/java/how-to-install-oracle-jdk-8-on-debian/
echo ">>>> Installing JDK 8 from Oracle ..."

cd /tmp
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" --progress=bar:force:noscroll --show-progress --quiet http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz

sudo mkdir /opt/jdk/
tar -zxf jdk-8u112-linux-x64.tar.gz -C /opt/jdk

sudo update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_112/bin/java 5000
sudo update-alternatives --install /usr/bin/jar jar /opt/jdk/jdk1.8.0_112/bin/jar 5000
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_112/bin/javac 5000

#sudo update-alternatives --config java // select version
sudo update-alternatives --set java /opt/jdk/jdk1.8.0_112/bin/java
sudo update-alternatives --set jar /opt/jdk/jdk1.8.0_112/bin/jar
sudo update-alternatives --set javac /opt/jdk/jdk1.8.0_112/bin/javac

echo -e "done\n"

