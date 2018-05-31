# UPYBBOT - micropython balaancing robot
# jeffm   - 23.4.2015

import pyb
from mpu6050 import MPU6050
imu = MPU6050(2,False)

from pyb import Timer
    
tim = Timer(8,freq=10000)


# Complementary Filter A = rt/(rt + dt) where rt is response time, dt = period
def compf(fangle,accel,gyro,looptime,A):
    fangle = A * (fangle + gyro * looptime/1000000) + (1-A) * accel
    return fangle

#  graphic display of accel angle & filtered angle
#   - primarily used in development but also for initial setup
def align():
    cangle = 90.0
    while abs(cangle)>2.0:
        angle  = imu.pitch()
        cangle = compf(cangle, angle, imu.get_gy(), pyb.elapsed_micros(start),0.91) 
        start = pyb.micros()


MAX_VEL = 2000 # 2000 usteps/sec = 500steps/sec = 2.5rps = 150rpm
MAX_ANGLE = 10  # degrees of tilt for speed control

def constrain(val,minv,maxv):
    if val<minv:
        return minv
    elif val>maxv:
        return maxv
    else:
        return val

#stability PD controiller - input is target angle, output is acceleration
K = 6 # 7
Kp = 4.0
Kd = 0.5
def stability(target,current,rate):
    global K,Kp,Kd
    error = target - current
    output = Kp * error - Kd*rate
    return int(K*output)

#speed P controiller - input is target speed, output is inclination angle
KpS = 0.01
def speedcontrol(target,current):
    global KpS
    error = target - current
    output = KpS * error 
    return constrain(output,-MAX_ANGLE,+MAX_ANGLE)

#main balance loop runs every 5ms
def balance():
    gangle = 0.0
    start = pyb.micros()
    controlspeed = 0
    fspeed = 0
    while abs(gangle) < 45:  # give up if inclination angle >=45 degrees
        angle  = imu.pitch()
        rate   = imu.get_gy()
        gangle = compf(gangle, angle, rate, pyb.elapsed_micros(start),0.99)         
        start = pyb.micros()
        # speed control
        actualspeed = (motor1.get_speed()+motor2.get_speed())/2
        fspeed = 0.95 * fspeed + 0.05 * actualspeed
        cmd = radio.poll() # cmd[0] is turn speed, cmd[1] is fwd/rev speed
        tangle = speedcontrol(800*cmd[1],fspeed)
         # stability control
        controlspeed += stability(tangle, gangle, rate)           
        controlspeed = constrain(controlspeed,-MAX_VEL,MAX_VEL)
        pyb.udelay(5000-pyb.elapsed_micros(start))
    
# main program
while True:
    align()
    tim.callback(issr) #start interrupt routine
    balance()
    tim.callback(None) #stop interrupt routine
         
   
        






              
