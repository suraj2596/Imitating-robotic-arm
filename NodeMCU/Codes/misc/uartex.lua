int i = 0;
byte startAddress;
byte servoID = 0xFE; // 0xFE is broadcast to all servos
byte ledOn = 0x01;
byte ledOff = 0x00;

uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)

uart.write(0xFF);  // 1.These 2 bytes are 'start message'
uart.write(0xFF);  // 2.These 2 bytes are 'start message'
uart.write(servoID);  // 3.ID is target servo or 0xfe which is broadcast mode
uart.write(0x04);  // 4.Length of string
uart.write(0x03);  // 5.Ping read write or syncwrite 0x01,2,3,83
uart.write(startAddress);  // 6.Start address for data to be written
uart.write(newValue);  //  7.Turning on signal
uart.write(notchecksum); //8. the notchecksum
