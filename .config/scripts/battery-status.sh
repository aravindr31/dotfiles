#!/bin/bash
   while true
    do
       export DISPLAY=:0.0
       battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
       on_ac_power=$(acpi -b | grep -c Charging )
       if [ $on_ac_power -eq 1 ]; then
           if [ $battery_level -ge 95 ]; then
              notify-send "Battery Full" "Level: ${battery_level}% "
              paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
           fi
       else
           if [ $battery_level -le 20 ]; then
              notify-send --urgency=NORMAL "Battery Low" "Level: ${battery_level}%"
              paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga 
           elif [ $battery_level -le 10 ]; then
              notify-send --urgency=CRITICAL "Battery Vritical" "Level: ${battery_level}%"   
              paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga 
           fi
       fi
     sleep 60
done
