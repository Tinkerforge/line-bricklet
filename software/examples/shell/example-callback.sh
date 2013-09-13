#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# set period for reflectivity callback to 1s (1000ms)
# note: the reflectivity callback is only called every second if the
#       reflectivity has changed since the last call!
tinkerforge call line-bricklet $uid set-reflectivity-callback-period 1000

# handle incoming reflectivity callbacks
tinkerforge dispatch line-bricklet $uid reflectivity
