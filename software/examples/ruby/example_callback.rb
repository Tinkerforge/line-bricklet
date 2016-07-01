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

# Register reflectivity callback
l.register_callback(BrickletLine::CALLBACK_REFLECTIVITY) do |reflectivity|
  puts "Reflectivity: #{reflectivity}"
end

# Set period for reflectivity callback to 1s (1000ms)
# Note: The reflectivity callback is only called every second
#       if the reflectivity has changed since the last call!
l.set_reflectivity_callback_period 1000

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
