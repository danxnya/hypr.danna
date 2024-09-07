#!/bin/bash

# Verificar si el monitor HDMI está conectado
if xrandr | grep "HDMI-A-1 connected"; then
    waybar
else
    waybar -c ~/.config/waybar/secondmonitor.jsonc
fi

