<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletLine.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletLine;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Line Bricklet

$ipcon = new IPConnection(); // Create IP connection
$l = new BrickletLine(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current reflectivity
$reflectivity = $l->getReflectivity();
echo "Reflectivity: $reflectivity\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
