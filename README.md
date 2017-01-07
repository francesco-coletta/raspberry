# raspberry

IP: 192.168.1.122


Username/password:pi/raspberry


Have been installed tightvnc server 

On client run (coletta/Downloads/tvnjviewer-2.7.2-bin ):
java -jar tightvnc-jviewer.jar
on 
192.168.1.122:5901
pwd:raspberry


Dopo l'avvio del raspberry accertarsi che sia attivo il servizio nfs necessario alla condivisione del FS dal raspberry alla Vm dev:
sudo service nfs-kernel-server restart
sudo service rpcbind restart


SETUP Crosscompile
---------------------------
Kolbans book

http://www.hertaville.com/development-environment-raspberry-pi-cross-compiler.html
http://www.htpcguides.com/configure-nfs-server-and-nfs-client-raspberry-pi/
https://mauriziosiagri.wordpress.com/tag/nfs-kernel-server/
http://blog.shahada.abubakar.net/post/raspberry-pi-software-development-with-a-cross-compiler

Install wirinPI on Raspi
------------------------
apt-get purge wiringpi
cd /tmp
git clone git://git.drogon.net/wiringPi
cd wiringPi
git pull origin
./build

Install libconfig++ on Raspi
------------------------
For c++:
sudo apt-get install libconfig++-dev

For c:
sudo apt-get install libconfig-dev

Install spdlog (NO)
------------------------
On dev machine clone 
git clone https://github.com/gabime/spdlog.git
and copy the folder
spdlog/include/spdlog
under project include
and read
https://github.com/gabime/spdlog/wiki/1.-QuickStart

Install easylogging++
------------------------
On dev machine clone 
git clone https://github.com/easylogging/easyloggingpp.git
and copy the header file
easyloggingpp/src/easylogging++.h
under project include
and read
https://github.com/easylogging/easyloggingpp/blob/master/README.md#install-optional
https://easylogging.muflihun.com/





Create project into Eclipse (on debian VM guest) and setup it
---------------------------
Ref:
http://blog.shahada.abubakar.net/post/raspberry-pi-software-development-with-a-cross-compiler
Kolbans book

Create Project in Eclipse

    File -> New -> Project -> C++ Project
        Key in Project Name ("Test")
        ToolChains: Cross GCC

    Next -> Next -> Next
        Cross Compiler Prefix : arm-linux-gnueabihf-
        Cross Compiler Path: /usr/local/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
        Cross Compiler Path: /usr/local/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin

    Project -> Properties ->
        Cross Gcc Compiler -> includes
            Add Paths: /mnt/pi/root/usr/local/include/
            Add Paths: /mnt/pi/root/usr/include/
            Add Paths: /mnt/pi/root/usr/include/arm-linux-gnueabihf/
        Cross G++ Compiler -> includes
            Add Paths: /mnt/pi/root/usr/local/include/
            Add Paths: /mnt/pi/root/usr/include/
            Add Paths: /mnt/pi/root/usr/include/arm-linux-gnueabihf/
            
            Add to Other Flags (if you want C++11) : --std=c++11 
        Cross G++ Linker -> libraries
            Add Libraries: wiringPi
            Add Libraries: config (config++)
            Add Library search paths: /mnt/pi/root/usr/local/lib/
            Add Library search paths: /mnt/pi/root/usr/lib/arm-linux-gnueabihf/


You can now compile and build C++ applications in Eclipse for the Raspbery Pi. You can split the app into multiple .h and .cpp files, and Eclipse will take care of the build. It also generates a Makefile (that uses the cross-compiler) so you can build from the command line.
To deploy, just scp the executables (usually under the project's "Debug/" folder) over to the Pi.

Username/password
http://wiringpi.com/examples/blink/
https://github.com/nkolban/PiBook
