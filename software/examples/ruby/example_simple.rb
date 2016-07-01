#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_line'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Line Bricklet

ipcon = IPConnection.new # Create IP connection
l = BrickletLine.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current reflectivity
reflectivity = l.get_reflectivity
puts "Reflectivity: #{reflectivity}"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
