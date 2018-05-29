#!/bin/sh

#internal monitor
intern=eDP1

#external monitor
extern=DP1

state="$(cat $HOME/.config/i3/state.txt)"

if xrandr | grep "$extern disconnected"; then
    polybar left 
    echo "Bar launched..."
else
    if [ $state = "single" ]; then 
        polybar rightMain    
        echo "Bar launched..."
    else        
        polybar right &
        polybar left
        echo "Bars launched..."        
    fi
fi
