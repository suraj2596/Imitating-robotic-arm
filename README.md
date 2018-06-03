# Imitating-robotic-arm

![Sensors](https://github.com/suraj2596/Imitating-robotic-arm/blob/master/SupportMaterial/Pictures/1)
![Hand](https://github.com/suraj2596/Imitating-robotic-arm/blob/master/SupportMaterial/Pictures/2)
![hand](https://github.com/suraj2596/Imitating-robotic-arm/blob/master/SupportMaterial/Pictures/3)

This is my Final Year Project of my BE in ECE, PESIT. 

The aim of the project is to build a robotic arm which could be controlled from anywhere in the world. 

The control strategy uses wearable device which captures user's hand movements via IMUs and transmitted via the MQTT. 

This project focuses on data capturing, framing and transmitting. 

2 IMUs were used with ESP8266. Library files were built from scratch using the IMU's data sheet and pseudo code. The IMU used is MPU6050 which works on I2C protocol

[comment]: # (Complementary filter 
http://www.pieter-jan.com/node/11
)

[comment]: # (MicroPython code for interacting with MPU6050 and ESP8266
https://github.com/larsks/py-mpu6050
)
