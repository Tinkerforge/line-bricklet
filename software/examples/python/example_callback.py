#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_line import Line

# Callback function for reflectivity
def cb_reflectivity(reflectivity):
    print('Reflectivity: ' + str(reflectivity))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    line = Line(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set Period for reflectivity callback to 1s (1000ms)
    # Note: The reflectivity callback is only called every second if the 
    #       reflectivity has changed since the last call!
    line.set_reflectivity_callback_period(1000)

    # Register reflectivity callback to function cb_reflectivity
    line.register_callback(line.CALLBACK_REFLECTIVITY, cb_reflectivity)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
