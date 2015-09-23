#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Handle incoming reflectivity callbacks
tinkerforge dispatch line-bricklet $uid reflectivity &

# Set period for reflectivity callback to 1s (1000ms)
# Note: The reflectivity callback is only called every second
#       if the reflectivity has changed since the last call!
tinkerforge call line-bricklet $uid set-reflectivity-callback-period 1000

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
