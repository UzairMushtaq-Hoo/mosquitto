# angieOS - HooControls Operating System Documentaion

## Installation/Setup of HooOS (Dev. Version) guide v0.1:
This is a guide how to install HooOS v0.1 on Ubuntu/Debian.

## 1. Install all the dependencies
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

### Install node js and Node Package Manager
***Installing the correct version of node may have hassle and requires some extra efforts sometimes. So, initially, Install node using the following command:***
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

### Install Angular
Install the angular cli globally by using `-g` argument:
```
sudo npm install -g @angular/cli@latest
```

## 2. Clone the required repositories
### HooOS:
If the user has no root privileges, then use `sudo bash` or you may choose the home directory where the user have enough permissions to read and write.
`cd ~`

This git repo is private so it may require an authentication if you already haven't logged in.  Before cloning the repository, must check if the repository has been shared with you by HooControlsInc.

```
git clone https://github.com/HooControlsInc/HooOS.git
```

Now, download the required node modules:
```
cd HooOS
sudo npm i
```

### Hoo Backend:
clone the repo using:
```
cd ~
git clone https://github.com/HooControlsInc/HooBackend.git
```
and, install the required modules:
```
cd HooBackend/
sudo npm i
```

### zigbee2mqtt:
```
cd ~
git clone https://github.com/koenkk/zigbee2mqtt.git
cd zigbee2mqtt
sudo npm ci
```
***OPTIONAL: Now, change the `devices.js` file in  `node_modules/zigbee-herdsman-converters` directory:***
Download devices.js from Hoo Repo which includes some additional supported devices, and replace it with the file in `zigbee2mqtt/node_modules/zigbee-herdsman-converters/devices.js`
```
```


### Install Mosquitto MQTT Broker:
Install Mosquitto MQTT Broker with Websockets
```
cd Downloads/
wget http://mosquitto.org/files/source/mosquitto-1.4.10.tar.gz
tar zxvf mosquitto-1.4.10.tar.gz
cd mosquitto-1.4.10/
```
***Edit `config.mk` file and replace `WITH_WEBSOCKETS:=no` with `WITH_WEBSOCKETS:=yes`:***
```
sudo nano config.mk
```
now, save & close the file:
`ctrl + O` & `Enter/Return` to save, and `ctrl + X` to exit.

***Now, Build mosquitto with following commands:***
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
now, save & close the file:
`ctrl + O` & `Enter/Return` to save, and `ctrl + X` to exit.

***Add user for mosquitto:***
```
sudo adduser mosquitto
```

## 3. Run / Test
Use a separate terminal window/tab for each of the following task:

* Start by running mqtt broker and specify configuration file with `-c` arg:
```
mosquitto -c /etc/mosquitto/mosquitto.conf
```
* Start zigbee2mqtt:
Move to the directory where zigbee2mqtt was cloned i.e, home: `cd ~/zigbee2mqtt` and run:
```
sudo npm start
```
**If the command ends with error, then try unplug and plug the zigbee dongle**
If the problem still exists, then try stopping the zigbee2mqtt service by using:
`sudo systemctl stop zigbee2mqtt.service`

* Now, start the Backend service:
Navigate to the respective directory: `cd ~/HooBackend/` and run:
```
node server.js
```
* At Last, start the UI by running the following command(s):
Navigate to `cd ~/HooOS`
```
ng serve --open
```

After all the above steps, if UI doesn't start then, open the browser tab:
```
localhost:4200
```


## 4. Optional
### Install Google Chrome (Firefox may not support touch functionality):
Download the latest version of google chrome according to the system's architecture:
```
cd ~
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```
Install using `dpkg`:
```
sudo dpkg -i google-chrome-stable_current_amd64.deb
```
Run:
`google-chrome-stable` or `google-chrome`

### How to change MQTT Broker IP:
Navigate to the app folder in HooOS directory and edit `app.module.ts` file:
```
cd ~/HooOS/src/app
sudo nano app.module.ts
```
`ctrl + O` & `Enter/Return` to save, and `ctrl + X` to exit.

and change the ip in `hostname` field.

