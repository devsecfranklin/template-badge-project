sudo apt install esptool -y
wget https://micropython.org/resources/firmware/esp32-20210902-v1.17.bin
esptool --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash -z 0x1000 esp32-20210902-v1.17.bin
rm esp32-20210902-v1.17.bin
