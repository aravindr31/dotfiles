#!/bin/bash

exec xautolock -detectsleep -time 5 -locker "/home/davidb/Applications/bin/lock" -notify 30 -notifier "notify-send -u critical -t 10000 --'Locking Screen in 30 sec'" &

exec xidlehook --not-when-audio --not-when-fullscreen --timer 1200 "systemctl suspend" - &
