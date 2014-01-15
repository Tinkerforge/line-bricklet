<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletLine.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletLine;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for reflectivity
function cb_reflectivity($reflectivity)
{
    echo "Reflectivity: " . $reflectivity . "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$line = new BrickletLine(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for reflectivity callback to 1s (1000ms)
// Note: The reflectivity callback is only called every second if the
//       reflectivity has changed since the last call!
$line->setReflectivityCallbackPeriod(1000);

// Register reflectivity callback to function cb_reflectivity
$line->registerCallback(BrickletLine::CALLBACK_REFLECTIVITY, 'cb_reflectivity');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
