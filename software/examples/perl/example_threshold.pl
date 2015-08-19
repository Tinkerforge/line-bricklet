#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletLine;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $l = Tinkerforge::BrickletLine->new(&UID, $ipcon); # Create device object

# Callback subroutine for reflectivity greater than 2000
sub cb_reflectivity_reached
{
    my ($reflectivity) = @_;

    print "Reflectivity: " . $reflectivity . "\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 1 second (1000ms)
$l->set_debounce_period(1000);

# Register threshold reached callback to subroutine cb_reflectivity_reached
$l->register_callback($l->CALLBACK_REFLECTIVITY_REACHED, 'cb_reflectivity_reached');

# Configure threshold for "greater than 2000"
$l->set_reflectivity_callback_threshold('>', 2000, 0);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
