#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get current reflectivity
tinkerforge call line-bricklet $uid get-reflectivity
