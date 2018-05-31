# Imitating-robotic-arm
---
![Sensors](https://github.com/suraj2596/Imitating-robotic-arm/blob/master/SupportMaterial/Pictures/1)
![Hand](https://github.com/suraj2596/Imitating-robotic-arm/blob/master/SupportMaterial/Pictures/2)
![hand](https://github.com/suraj2596/Imitating-robotic-arm/blob/master/SupportMaterial/Pictures/3)

This is my Final Year Project of my BE in ECE. 

The aim of the project is to build a robotic arm which could be placed anywhere in the world. 

The user's hand movements are captured via IMUs and transmitted via the internet. 

This project focuses on data capturing and transmitting. Later, a ROS model will be developed and integrated to the existing project.

2 IMUs were used with ESP8266. Library files were built from scratch using the IMU's data sheet. The IMU used was MPU6050 which works on I2C protocol

Currently working on applying some predictive modelling on the sensor data.

Complementary filter 
http://www.pieter-jan.com/node/11

MicroPython code for interacting with MPU6050 and ESP8266
https://github.com/larsks/py-mpu6050
