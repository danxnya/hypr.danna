#!/bin/bash

# Verificar si el monitor HDMI está conectado
if xrandr | grep "HDMI-A-1 connected"; then
    waybar -c ~/.config/waybar/configHD
else
    waybar -c ~/.config/waybar/configDP
fi

