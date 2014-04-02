#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletLine;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $line = Tinkerforge::BrickletLine->new(&UID, $ipcon); # Create device object

# Callback for reflectivity greater than 2000 Lux
sub cb_reached
{
    my ($reflectivity) = @_;

    print "Reflectivity: $reflectivity\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 1 seconds (1000ms)
$line->set_debounce_period(1000);

# Register threshold reached callback to function cb_reached
$line->register_callback($line->CALLBACK_REFLECTIVITY_REACHED, 'cb_reached');

# Configure threshold for "greater than 2000 Lux"
$line->set_reflectivity_callback_threshold('>', 2000, 0);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

