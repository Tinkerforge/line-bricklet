#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_line import Line

# Callback for reflectivity greater than 2000 Lux
def cb_reached(reflectivity):
    print('Reflectivity: ' + str(reflectivity))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    line = Line(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    line.set_debounce_period(1000)

    # Register threshold reached callback to function cb_reached
    line.register_callback(line.CALLBACK_REFLECTIVITY_REACHED, cb_reached)

    # Configure threshold for "greater than 2000 Lux"
    line.set_reflectivity_callback_threshold('>', 2000, 0)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
