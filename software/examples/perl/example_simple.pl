#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletLine;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $l = Tinkerforge::BrickletLine->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current reflectivity
my $reflectivity = $l->get_reflectivity();
print "Reflectivity: " . $reflectivity . "\n";

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
