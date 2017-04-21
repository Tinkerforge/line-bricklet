#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Line Bricklet

# Get threshold callbacks with a debounce time of 1 second (1000ms)
tinkerforge call line-bricklet $uid set-debounce-period 1000

# Handle incoming reflectivity reached callbacks
tinkerforge dispatch line-bricklet $uid reflectivity-reached &

# Configure threshold for reflectivity "greater than 2000"
tinkerforge call line-bricklet $uid set-reflectivity-callback-threshold threshold-option-greater 2000 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
