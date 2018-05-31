import gc
import network
import machine
from machine import Pin

gc.collect()

ap_if = network.WLAN(network.AP_IF)
ap_if.config(essid='Juliett India Oscar', password='connected@123')
ap_if.active()
