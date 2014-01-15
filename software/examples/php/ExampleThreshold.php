<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletLine.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletLine;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback for reflectivity greater than 2000
function cb_reached($reflectivity)
{
    echo "Reflectivity: " . $reflectivity . "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$line = new BrickletLine(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 1 second (1000ms)
$line->setDebouncePeriod(1000);

// Register threshold reached callback to function cb_reached
$line->registerCallback(BrickletLine::CALLBACK_REFLECTIVITY_REACHED, 'cb_reached');

// Configure threshold for "greater than 2000"
$line->setReflectivityCallbackThreshold('>', 2000, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
