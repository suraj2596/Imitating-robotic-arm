esptool.py --port /dev/ttyUSB* erase_flash
esptool.py --port /dev/ttyUSB* --baud 460800 write_flash --flash_size=detect 0 nodemcu-1.5.4.1-final-12-modules-2017-04-27-10-01-17-float.bin
