#!/bin/sh

logfile=/var/log/monitor-hotplug.log

/bin/date 2>&1 >> $logfile

function print() {
    echo "$1" >> $logfile
}

card=card0-HDMI-A-2

status=$(cat /sys/class/drm/$card/status)

output=HDMI2

if [ "$status" == "connected" ]; then
	sleep 10; # the trailing semi-column is necessary
	# This command is necessary otherwise xrandr doesn't see HDMI2 as connected
	xrandr 2>&1 >> /dev/null
	xrandr --verbose --output eDP1 --auto --pos 1520x2880 --scale 1x1 --output $output --mode 3440x1440 --scale 2x2 --pos 0x0 2>&1 >> $logfile
	print "HDMI2 output added"

elif [ "$status" == "disconnected" ]; then
	xrandr --output $output --off
	print "HDMI2 output removed"
else
	print "Unknown status '$status' for card $card"
fi

