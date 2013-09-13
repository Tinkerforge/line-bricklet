#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get threshold callbacks with a debounce time of 1 seconds (1000ms)
tinkerforge call line-bricklet $uid set-debounce-period 1000 

# configure threshold for "greater than 2000"
tinkerforge call line-bricklet $uid set-reflectivity-callback-threshold greater 2000 0

# handle incoming reflectivity-reached callbacks
tinkerforge dispatch line-bricklet $uid reflectivity-reached
