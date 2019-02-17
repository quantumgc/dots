#!/bin/sh


if [ "$(pgrep -x redshift)" ]; then
    notify-send "turning redshift off"
    systemctl --user stop redshift.service
else
    notify-send "turning redshift on"
    systemctl --user start redshift.service
fi
