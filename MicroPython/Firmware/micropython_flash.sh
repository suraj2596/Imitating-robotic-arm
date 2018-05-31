esptool.py --port /dev/ttyUSB* erase_flash
esptool.py --port /dev/ttyUSB* --baud 460800 write_flash --flash_size=detect 0 esp8266-20170108-v1.8.7.bin
