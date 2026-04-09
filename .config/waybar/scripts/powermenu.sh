#!/bin/bash
chosen=$(echo -e "Logout\nSuspend\nReboot\nShutdown" | rofi -dmenu -p "Power")
case "$chosen" in
  Logout)   hyprctl dispatch exit ;;
  Suspend)  systemctl suspend ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
