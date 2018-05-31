from machine import I2C

i2c = I2C(0)                         # create on bus 0
i2c = I2C(0, I2C.MASTER)             # create and init as a master
i2c.init(I2C.MASTER, baudrate=20000) # init as a master

i2c.scan()
