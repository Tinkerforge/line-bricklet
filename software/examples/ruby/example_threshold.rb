#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_line'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
l = BrickletLine.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 1 second (1000ms)
l.set_debounce_period 1000

# Register threshold reached callback for reflectivity greater than 2000
l.register_callback(BrickletLine::CALLBACK_REFLECTIVITY_REACHED) do |reflectivity|
  puts "Reflectivity: #{reflectivity}"
end

# Configure threshold for "greater than 2000"
l.set_reflectivity_callback_threshold '>', 2000, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
