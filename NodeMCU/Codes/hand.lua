-- Global Variables (Modify for your network)
ssid = "JARUS"
pass = "connected@123"

-- Configure Wireless Internet
wifi.setmode(wifi.STATION)
cfg =
  {
    ip="192.168.1.200",
    netmask="255.255.255.0",
    gateway="192.168.1.1"
  }
wifi.sta.setip(cfg)
wifi.sta.config(ssid,pass)
wifi.sta.autoconnect(1)

-- Connect 
print('\nAll About Circuits main.lua\n')
tmr.alarm(0, 1000, 1, function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...\n")
   else
      ip, nm, gw=wifi.sta.getip()
      print("IP Info: \nIP Address: ",ip)
      print("Netmask: ",nm)
      print("Gateway Addr: ",gw,'\n')
      tmr.stop(0)
   end
end)

 -- Start a simple http server
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
  conn:on("receive",function(conn,payload)
    write_reg_MPU(0x6B, 7)
    new_data_interrupt()
    conn:send('<meta http-equiv="refresh" content="1" >')
    conn:send('<p>Ax Value: '..Ax..'</p><br>')
  end)
  conn:on("sent",function(conn) conn:close() end)
end)


--domoticz.lua
sda, scl = 5, 4

avg_x = 0
avg_y = 0
avg_z = 0
report_data = 0
aggregate_counter = 0
bigger_aggregate_counter = 0
aggregate_ax_val = 0
aggregate_ay_val = 0
aggregate_az_val = 0

aggregate_abs_ax_val = 0
aggregate_abs_ay_val = 0
aggregate_abs_az_val = 0

function write_reg_MPU(reg,val)
  i2c.start(0)
  i2c.address(0, 0x68, i2c.TRANSMITTER)
  i2c.write(0, reg)
  i2c.write(0, val)
  i2c.stop(0)
end

function read_reg_MPU(reg)
  i2c.start(0) 
  i2c.address(0, 0x68, i2c.TRANSMITTER)
  i2c.write(0, reg)
  i2c.stop(0)
  i2c.start(0)
  i2c.address(0, 0x68, i2c.RECEIVER)
  c=i2c.read(0, 1)
  i2c.stop(0)
  --print(string.byte(c, 1))
  return c
end

function new_data_interrupt()
    -- clear interrupt
    read_reg_MPU(58)
    
    -- read acceleration data
    i2c.start(0)
    i2c.address(0, 0x68, i2c.TRANSMITTER)
    i2c.write(0, 59)
    i2c.stop(0)
    i2c.start(0)
    i2c.address(0, 0x68, i2c.RECEIVER)
    c=i2c.read(0, 8)
    i2c.stop(0)

    Ax=bit.lshift(string.byte(c, 1), 8) + string.byte(c, 2)
    Ay=bit.lshift(string.byte(c, 3), 8) + string.byte(c, 4)
    Az=bit.lshift(string.byte(c, 5), 8) + string.byte(c, 6)
    temperature=bit.lshift(string.byte(c, 7), 8) + string.byte(c, 8)

    if (Ax > 0x7FFF) then
        Ax = Ax - 0x10000;
    end
    --print(Ax)
    if (Ay > 0x7FFF) then
        Ay = Ay - 0x10000;
    end
    --print(Ay)
    if (Az > 0x7FFF) then
        Az = Az - 0x10000;
    end
    --print(Az)
    return
end

---test program
i2c.setup(0, sda, scl, i2c.SLOW)                    -- init i2c
i2c.start(0)                                        -- start i2c
c = i2c.address(0, 0x68, i2c.TRANSMITTER)       -- see if something answers
i2c.stop(0)                                     -- stop i2c

if c == true then
    print("Device found at address : "..string.format("0x%X",0x68))
else 
    print("Device not found !!")
end

c = read_reg_MPU(117)                               -- Register 117 – Who Am I - 0x75
if string.byte(c, 1) == 104 then 
    print("MPU6050 Device answered OK!")
else 
    print("Check Device - MPU6050 NOT available!")
end

read_reg_MPU(107)                                   -- Register 107 – Power Management 1-0x6b
if string.byte(c, 1)==64 then 
    print("MPU6050 in SLEEP Mode !")
else
    print("MPU6050 in ACTIVE Mode !")
end

write_reg_MPU(0x6B, 0)                              -- Initialize MPU, use 8MHz clock
write_reg_MPU(25, 1)                              -- Sample Rate = Gyroscope Output Rate / (1 + SMPLRT_DIV) >> 40Hz
--write_reg_MPU(35, 0x00)
write_reg_MPU(56, 0x01)                             -- Enables the Data Ready interrupt, which occurs each time a write operation to all of the sensor registers has been completed.

gpio.mode(8, gpio.INT, gpio.PULLUP)                 -- set d8 as input interrupt
gpio.trig(8, "up", new_data_interrupt)              -- new data interupt handler