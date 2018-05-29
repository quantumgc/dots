#!/bin/sh
# Xsetup - run as root before the login dialog appears

#internal monitor
intern="eDP1"

#external monitor
extern="DP1"

#state
state="$(cat $HOME/.config/i3/state.txt)"

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    if [ $state = "single" ]; then
        xrandr --output "$intern" --off --output "$extern" --auto
    else        
        xrandr --output "$intern" --primary --auto --output "$extern" --left-of "$intern" --auto
    fi
fi
