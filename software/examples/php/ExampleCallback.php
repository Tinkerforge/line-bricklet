<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletLine.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletLine;

$host = 'localhost';
$port = 4223;
$uid = 'XYZ'; // Change to your UID

// Callback function for reflectivity
function cb_reflectivity($reflectivity)
{
    echo "Reflectivity: " . $reflectivity . "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$al = new BrickletLine($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for reflectivity callback to 1s (1000ms)
// Note: The reflectivity callback is only called every second if the
//       reflectivity has changed since the last call!
$al->setReflectivityCallbackPeriod(1000);

// Register reflectivity callback to function cb_reflectivity
$al->registerCallback(BrickletLine::CALLBACK_REFLECTIVITY, 'cb_reflectivity');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
