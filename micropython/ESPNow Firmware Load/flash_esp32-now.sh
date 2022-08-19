sudo apt install esptool -y
#wget 'https://github.com/glenn20/micropython-espnow-images/blob/main/20210903_espnow-g20-v1.17/firmware-esp32-GENERIC.bin'
esptool --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash -z 0x1000 firmware-esp32-GENERIC.bin
#rm firmware-esp32-GENERIC.bin

