#!/usr/bin/env python

import os

SERVICE="bluetooth"
STATUS=os.system("systemctl is-active "+SERVICE+"")
RUNNING=os.system("systemctl show -p SubState "+SERVICE+" | cut -d'=' -f2")
CONNECTED_MAC=os.system("bluetoothctl info | grep Device")
Device=os.system("bluetoothctl info | grep Name | cut -d ':' -f2")
DEVICE_NAME=str(Device)
Truncated_Name= DEVICE_NAME[:15] + (DEVICE_NAME[15:] and "..." )

print (type(STATUS))
#print (DEVICE_NAME,Truncated_Name)

if((STATUS=="active") and (RUNNING=="running") and (CONNECTED_MAC)):
    print ("  "+Truncated_Name)
#    print ("here")
elif((STATUS=="active") and (RUNNING=="running") and (CONNECTED_MAC=="")):
    print ("  ")
elif(STATUS=="inactive"):
    print ("  ")
else:
    print ("  ")
