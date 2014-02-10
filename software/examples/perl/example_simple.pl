#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletLine;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $line = Tinkerforge::BrickletLine->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current reflectivity
my $reflectivity = $line->get_reflectivity();

print "\nReflectivity: $reflectivity\n";

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

