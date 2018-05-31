--local timer = require 'timer'

--FUNCTIONS
node.setcpufreq(node.CPU160MHZ)

function init_I2C()
    i2c.setup(bus, sda, scl, i2c.SLOW)
end

function read_reg_MPU(reg)
  i2c.start(bus) 
  i2c.address(bus, dev_addr, i2c.TRANSMITTER)
  i2c.write(bus, reg)
  i2c.stop(bus)
  i2c.start(bus)
  i2c.address(bus, dev_addr, i2c.RECEIVER)
  c=i2c.read(bus, 1)
  i2c.stop(bus)
  --print(string.byte(c, 1))
  return c
end

function write_reg_MPU(reg,val)
  i2c.start(bus)
  i2c.address(bus, dev_addr, i2c.TRANSMITTER)
  i2c.write(bus, reg)
  i2c.write(bus, val)
  i2c.stop(bus)
end

function init_MPU(reg,val)  --(107) 0x6B / 0
   write_reg_MPU(reg,val)
end

function status_MPU(dev_addr)
     i2c.start(bus)
     c=i2c.address(bus, dev_addr ,i2c.TRANSMITTER)
     i2c.stop(bus)
     if c==true then
        print(" Device found at address : "..string.format("0x%X",dev_addr))
     else print("Device not found !!")
     end
end

function check_MPU(dev_addr)
   print("")
   status_MPU(0x68)
   read_reg_MPU(117) --Register 117 – Who Am I - 0x75
   if string.byte(c, 1)==104 then print(" MPU6050 Device answered OK!")
   else print("  Check Device - MPU6050 NOT available!")
        return
   end
   read_reg_MPU(107) --Register 107 – Power Management 1-0x6b
   if string.byte(c, 1)==64 then print(" MPU6050 in SLEEP Mode !")
   else print(" MPU6050 in ACTIVE Mode !")
   end
end

function read_MPU_raw()
  tmr.wdclr()
  i2c.start(bus)
  i2c.address(bus, dev_addr, i2c.TRANSMITTER)
  i2c.write(bus, 59)
  i2c.stop(bus)
  i2c.start(bus)
  i2c.address(bus, dev_addr, i2c.RECEIVER)
  c=i2c.read(bus, 14)
  i2c.stop(bus)
  
  Ax=bit.lshift(string.byte(c, 1), 8) + string.byte(c, 2)
  Ay=bit.lshift(string.byte(c, 3), 8) + string.byte(c, 4)
  Az=bit.lshift(string.byte(c, 5), 8) + string.byte(c, 6)
  Gx=bit.lshift(string.byte(c, 9), 8) + string.byte(c, 10)
  Gy=bit.lshift(string.byte(c, 11), 8) + string.byte(c, 12)
  Gz=bit.lshift(string.byte(c, 13), 8) + string.byte(c, 14)

  print("Ax:"..Ax.."     Ay:"..Ay.."      Az:"..Az.."     Gx:"..Gx.."   Gy:"..Gy.."   Gz:"..Gz)

  --print("Gx:"..Gx.."   Gy:"..Gy.."   Gz:"..Gz)
  --print("\nTempH: "..string.byte(c, 7).." TempL: "..string.byte(c, 8).."\n")

  return c, Ax, Ay, Az, Gx, Gy, Gz
end

---test program
dev_addr = 0x68 --104
bus = 0
sda, scl = 5,4
init_I2C()
init_MPU(0x6B,0) 

check_MPU(0x68)

read_MPU_raw()

-- read data from MPU6050 every 1s 
--tmr.alarm(0, 1500, 1, function() read_MPU_raw() end)

--timer.setInterval(function() read_MPU_raw() end, 1000)

--mytimer = tmr.create()
--mytimer:register(10000, tmr.ALARM_AUTO, function() read_MPU_raw() end)
--mytimer:interval(1000) -- actually, 3 seconds is better!
--mytimer:start()


--stop tmr when done 
--tmr.stop(0)

