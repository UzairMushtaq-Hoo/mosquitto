#!/bin/bash

#installations
sudo apt-get -y  update && upgrade
sudo apt-get -y  install git
sudo apt -y  install wget
sudo apt-get -y  install nodejs
sudo apt-get -y  install npm
npm install -g @angular/cli@9

sudo apt-get -y  install build-essential python quilt python-setuptools python3
sudo apt-get -y  install libssl-dev
sudo apt-get -y  install cmake
sudo apt-get -y  install libc-ares-dev
sudo apt-get -y  install uuid-dev
sudo apt-get -y  install daemon
sudo apt-get -y  install libwebsockets-dev

#git cloning
sudo bash
cd /opt
git clone https://github.com/koenkk/zigbee2mqtt.git
cd zigbee2mqtt
npm i
cd ..
git clone https://github.com/HooControlsInc/HooOS.git
npm i
cd ..
wget https://github.com/HooControlsInc/Zigbee2Mqtt/tree/master/node_modules/zigbee-herdsman-converters

#mosquitto
wget https://github.com/UzairMushtaq-Hoo/mosquitto.git
unzip mosquitto-1.4.10
cd mosquitto-1.4.10/
make
sudo make install
sudo cp mosquitto.conf /etc/mosquitto
#mosquitto settings
cd /etc/mosquitto
rm mosquitto.conf
echo "
listner 1883
listner 8080
protocol websockets" > mosquitto.conf

#Replace device.js
cd /opt
sudo chmod 777 zigbee2mqtt
sudo mv devices.js /opt/zigbee2mqtt/node_modules/zigbee-herdsman-converters/devices.js

#start UI (If electron App)
#/opt/HooOS/release-builds/x64/angieOS/angieOS

exit

#start mosquitto
sudo mosquitto -c /etc/mosquitto/mosquitto.conf
#start z2m
cd /opt/zigbee2mqtt
sudo npm start

#IF angular proj
cd /opt/HooOS
sudo ng serve --open

