#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletLine;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $l = Tinkerforge::BrickletLine->new(&UID, $ipcon); # Create device object

# Callback subroutine for reflectivity callback
sub cb_reflectivity
{
    my ($reflectivity) = @_;

    print "Reflectivity: $reflectivity\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set period for reflectivity callback to 1s (1000ms)
# Note: The reflectivity callback is only called every second
#       if the reflectivity has changed since the last call!
$l->set_reflectivity_callback_period(1000);

# Register reflectivity callback to subroutine cb_reflectivity
$l->register_callback($l->CALLBACK_REFLECTIVITY, 'cb_reflectivity');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
