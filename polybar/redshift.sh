#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""




if [ "$(pgrep -x redshift)" ]; then
    temp=$(redshift -p 2> /dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")

    if [ -z "$temp" ]; then
        echo "%{F#65737E}$icon"
    elif [ "$temp" -ge 5000 ]; then
        echo "%{F#8FA1B3}$icon $temp K"
    elif [ "$temp" -ge 4000 ]; then
        echo "%{F#EBCB8B}$icon $temp K"
    else
        echo "%{F#D08770}$icon $temp K"
    fi
else
    echo "%{F#65737E}$icon"
fi
