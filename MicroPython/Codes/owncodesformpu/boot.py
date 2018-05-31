# This file is executed on every boot (including wake-boot from deepsleep)
#import esp
#esp.osdebug(None)
import gc
#import webrepl
#webrepl.start()
gc.collect()
def do_connect():
    import network
    sta_if = network.WLAN(network.STA_IF)
    if not sta_if.isconnected():
        print('connecting to network...')
        sta_if.active(True)
        sta_if.ifconfig(('192.168.1.200', '255.255.255.0', '192.168.1.1', '8.8.8.8'))
        sta_if.connect('Juliett India Oscar', 'connected@123')
        while not sta_if.isconnected():
            pass
    print('network config:', sta_if.ifconfig())
do_connect()

