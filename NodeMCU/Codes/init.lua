-- Global Variables (Modify for your network)
i=0

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

dofile('with_interrupts.lua')
--domoticz.lua
