#!/bin/sh
sleep 1
xrandr --output DP1 --right-of HDMI1 --left-of eDP1
sleep 1
xrandr --output HDMI1 --left-of DP1
xinput --set-prop 'Logitech Gaming Mouse G400' 'Device Accel Constant Deceleration' 3
xinput --set-prop 'Logitech Gaming Mouse G400' 'Device Accel Velocity Scaling' 1
sleep 1
nitrogen --restore
