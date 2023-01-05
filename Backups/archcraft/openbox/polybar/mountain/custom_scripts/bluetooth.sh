#!/bin/bash
#
#Check bluetooth status
#
service="bluetooth"
STATUS="$(systemctl is-active $service)"
RUNNING="$(systemctl show -p SubState $service | cut -d'=' -f2)"
CONNECTED_MAC=$(bluetoothctl info | grep Device)
if [ "${STATUS}" = "active" ] && [ "${RUNNING}" = "running" ] && [ ! -z "$CONNECTED_MAC" ]
then
    echo "  $(bluetoothctl info | grep Name | cut -d ":" -f2) "
elif [ "${STATUS}" = "active" ] && [ "${RUNNING}" = "running" ] && [ -z "$CONNECTED_MAC" ]
then
    echo "  "
elif [ "${STATUS}" = "inactive" ]
then
    echo "  "
else
    echo "  "
fi


