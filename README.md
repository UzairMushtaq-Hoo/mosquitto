# angieOS - HooControls Documentaion

## Installation/Setup of HooOS (Dev. Version) guide v0.1:
This is a guide how to install HooOS v0.1 on Ubuntu/Debian.

### Install all the dependencies
```
sudo apt-get -y  update && upgrade
sudo apt-get -y  install git
sudo apt -y  install wget
sudo apt-get -y  install build-essential python quilt python-setuptools python3
sudo apt-get -y  install libssl-dev
sudo apt-get -y  install cmake
sudo apt-get -y  install libc-ares-dev
sudo apt-get -y  install uuid-dev
sudo apt-get -y  install daemon
sudo apt-get -y  install libwebsockets-dev
```

#### Install node js and Node Package Manager
**Installing the corect version of node may have hassle and requires some extra efforts sometiimes. So, firstly, Install node using the following command:**
```
sudo apt-get -y  install nodejs
```
```
sudo apt-get -y  install npm
```
Check the version of node:
```
node -v
```
If it is 12.0+ or newer, then it's fine!
But, in case if the version is older, then you need to download the latest package from node website and intall it:
```
sudo apt install -y curl

# Using Ubuntu
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Using Debian, as root
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
```
Now, check the version of installed nodejs version by:
```
node -v
```
It should be newer now!

#### Install Angular
Install the angular cli globally by using `-g` argument:
```
sudo npm install -g @angular/cli@latest
```

### Clone the required repositories
#### HooOS
If the user has no root privileges, then use `sudo bash` or you may choose the home directory where the user have enough permissions to read and write.
`cd ~`

This git repo is private so it may require an authentication if you already haven't logged in.  Before cloning the repository, must check if the repository has been shared with you by HooControlsInc.

```git clone https://github.com/HooControlsInc/HooOS.git
```

Now, download the required node modules:
```
cd HooOS
npm i
```

#### Hoo Backend
```cd ~
git clone https://github.com/HooControlsInc/HooBackend.git
cd HooBackend
npm i
```

#### zigbee2mqtt
```
cd ~
git clone https://github.com/koenkk/zigbee2mqtt.git
cd zigbee2mqtt
npm ci
```
**Now, change the `devices.js` file in  `node_modules\zigbee-herdsman-converters` directory:**


#### Install Mosquitto MQTT Broker
Install Mosquitto MQTT Broker with Websockets
```
cd Downloads/
wget http://mosquitto.org/files/source/mosquitto-1.4.10.tar.gz
tar zxvf mosquitto-1.4.10.tar.gz
cd mosquitto-1.4.10/
```
**Edit `config.mk` file and replace `WITH_WEBSOCKETS:=no` with `WITH_WEBSOCKETS:=yes`:**
```
sudo nano config.mk
```
**Now, Build mosquitto with following commands:**
```
make
sudo make install
sudo cp mosquitto.conf /etc/mosquitto
```
***Configure ports for mosquitto***

Add the following lines to /etc/mosquitto/mosquitto.conf in the "Default Listener" section:
Edit:
```
sudo nano /etc/mosquitto/mosquitto.conf
```
and add:
```
listener 1883
listener 8080
protocol websockets
```
***Add user for mosquitto:***
```
sudo adduser mosquitto
```



