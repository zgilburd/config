#!/bin/sh
sleep 1
xrandr --output DP-1 --right-of HDMI-1 --left-of eDP-1
sleep 1
xrandr --output HDMI-1 --left-of DP-1
xinput --set-prop 'Logitech Gaming Mouse G400' 'Device Accel Constant Deceleration' 3
xinput --set-prop 'Logitech Gaming Mouse G400' 'Device Accel Velocity Scaling' 1
sleep 1
nitrogen --restore
