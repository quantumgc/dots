#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#internal monitor
intern="eDP1"

#external monitor
extern="DP1"

state="$(cat $HOME/.config/i3/state.txt)"

if xrandr | grep "$extern disconnected"; then
    polybar InternMain &
    polybar InternBottom    
    echo "Bar launched..."
else
    if [ $state = "single" ]; then 
        polybar ExternMain &
        polybar ExternBottom
        echo "Bar launched..."
    else
        polybar ExternMain &
        polybar InternSide &
        polybar ExternBottom2     
        echo "Bars launched..."        
    fi
fi
