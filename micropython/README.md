# ESP-32 Micropython and Badge Code Instructions
These instructions will take you through:
 - Installing the tools you need to Flash firmware to the ESP-32
 - Downloading and flashing the ESPNow micropython firmware to an ESP-32
 - Installing the tools necessary to communicate and upload/download files to the ESP-32
 - Establishing commmunication with the ESP-32
 - Uploading python code to the ESP-32
 - Invoking python code on the ESP-32

## Set Up Your Environment
I am starting with a fresh install of Ubuntu 20.04 Desktop 64-bit running on a RaspberryPi 4 (because what else was I going to use it for?) that is connected to WiFi and has access to the Internet.

Let's make sure the OS is up-to-date and has pip installed:
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install python-pip -y
```

Install esptool - We will use this to write firmware to the ESP-32 flash
```
sudo apt install esptool -y
```

Install rshell - We will use this to modify files on the ESP-32 and provide a terminal
```
sudo pip3 install rshell
```

Modify permissions to allow access to the serial ports without being root
```
sudo usermod -a -G dialout $USER
```
## Download and Flash ESPnow Micropython Firmware

Download the ESPnow firmware image:
```
wget 'https://github.com/glenn20/micropython-espnow-images/blob/main/20210903_espnow-g20-v1.17/firmware-esp32-GENERIC.bin'
```

Use esptool to flash firmware to the ESP-32 (Assuming your board is attached as ttyUSB0)
```
esptool --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash -z 0x1000 firmware-esp32-GENERIC.bin
```

## Copy and Execute Python Files

- Clone or pull the latest update to the repo
- Start rshell from the directory containing the python files you want to upload to the ESP-32
```
rshell
```
- From rshell, connect to the ESP-32
```
connect serial /dev/ttyUSB0
```
- Copy the target file to the ESP-32
```
cp badge.py /pyboard/
```
- Use the terminal in rshell to interact with the ESP-32 REPL
```
repl
```
- From the terminal, trigger execution of the python script uploaded to the ESP-32
```
import badge
```
 - To stop execution of the script, use ```Ctrl-C```
 - To exit REPL and return to rshell, use ```Ctrl-X```
 

## Automatic Execution of Python Code

To cause the ESP-32 to execute a Python script automatically upon boot:
- Create a file called 'boot.py' with a line 'import badge'
- Upload boot.py to /pyboard/
