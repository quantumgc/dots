#!/bin/bash

#####################
# Based on Sleeper cell by Jeff Israel
# http://how-to.wikia.com/wiki/Howto_turn_off_XScreenSaver_and_DPMS_while_watching_videos/noxsaver_script
# licenced under the GPL
#
# usage:
# XSSToggle TIME
# will turn XScreenSaver off for TIME seconds, displaying a notification.
# This kills any previous instances of XSSToggle.
# XSSToggle XSSON
# will kill the instance of XSSToggle with the PID specified in PIDFILE
#
PIDFILE="$HOME/.cache/XSSToggle.pid"
rx='^[0-9]+$'

if [ ! $1 ]; then
    echo "NO ARGUMENT"
elif [ "$1" == "XSSON" ]; then
    if [ -f "$PIDFILE" ]; then
        kill -9 $(cat "$PIDFILE")
    else
        echo "NO PIDFILE"
    fi
elif [[ "$1" =~ $rx ]]; then
    if [ -f "$PIDFILE" ]; then
        notify-send "Killing previous instances of XSSToggle"
        kill -9 $(cat "$PIDFILE")
    else
    notify-send "Turning off xsceensaver and dpms for $(($1/3600)):$(($1/60%60)):$(($1%60))"
    #xset s off -dpms

    sleep $1 &
    echo $! > "$PIDFILE"
    wait $!

    if [ -f "$PIDFILE" ]; then
        rm "$PIDFILE"
    fi
    notify-send "xscreensaver is back on"
    #xset s on +dpms
else
    echo "ARGUMENT $1 NOT RECOGNISED"
fi



