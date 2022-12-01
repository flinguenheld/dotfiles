#!/bin/bash

case "$1" in
    lock)
        i3lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        systemctl suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    poweroff)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|poweroff}"
        exit 2
esac

exit 0
