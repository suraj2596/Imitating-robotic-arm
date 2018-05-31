-- https://github.com/nodemcu/nodemcu-firmware/wiki/nodemcu_api_en


-- One time ESP Setup --
print("hi")
wifi.setmode(wifi.STATION)
wifi.sta.config ( "208" , "ritin@208" )  
print(wifi.sta.getip())

