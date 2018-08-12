# ecoPlace firmware  nodos

"""
Micropython | Board
0|D3
2|D4 (~Led1)*
4|D2
5|D1
9|SD2
10|SD3
12|D6
13|D7
14|D5
15|D8
16|D0 (~Led2)*
"""

# mudules.
import dht
import machine # GPIO manager.
import time # module time for delays and timers
import network 
import urequests

#requests
url =  'http://192.168.137.1/ecoplaces/public/index.php/api/Adddata'
headers = {'content-type': 'application/json'}
ID_Device = 2 # id device

#Wifi config
sta_if = network.WLAN(network.STA_IF) # station
ap_if = network.WLAN(network.AP_IF) # a_point

#tem and hum sersor
d = dht.DHT11(machine.Pin(4)) # for nodeMCU pin D2
adc = machine.ADC(0) # for analoga input

sta_if.active(True)  # set config station
ap_if.active(False) # clear  A. Point
 
#connet wifi network
#sta_if = network.WLAN(network.STA_IF)
if not sta_if.isconnected():
    print('conectando...')
    sta_if.active(True)
    sta_if.connect('galeano', '35901294')
    while not sta_if.isconnected():
        pass
print('red configurada:', sta_if.ifconfig())

while True:
    
    cout = 0
    while cout < 3:
        try:
            d.measure() # get measures
            break
        except:
            cout = cout + 1    

    if cout < 3:
        
        #
        #print ("T{0}".format(d.temperature()))
        #print ("H{0}".format(d.humidity()))
        #Data Sensor Sond
        #print ("S{0}".format(adc.read()))

        #api-rest connetion
        data = '{"aire": '+str(d.humidity())+',"temperatura": '+str(d.temperature())+',"sonido": '+str(adc.read())+',"longitud": 1.3232,"latitud": 54.3232,"lugar": "Medellin","iddevice": '+str(ID_Device)+' }'
        resp = urequests.post(url, data=data, headers=headers)
        print(resp.json())
        
    time.sleep(1) # send every 1s

    
 