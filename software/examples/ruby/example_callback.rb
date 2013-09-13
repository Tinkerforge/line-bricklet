#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_line'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
line = BrickletLine.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for reflectivity callback to 1s (1000ms)
# Note: The reflectivity callback is only called every second if the 
#       reflectivity has changed since the last call!
line.set_reflectivity_callback_period 1000

# Register reflectivity callback (parameter has unit Lux/10)
line.register_callback(BrickletLine::CALLBACK_REFLECTIVITY) do |reflectivity|
  puts "Reflectivity: #{reflectivity}"
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
