#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Line Bricklet

# Get current reflectivity
tinkerforge call line-bricklet $uid get-reflectivity
