var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'j6q'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var line = new Tinkerforge.BrickletLine(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Get threshold callbacks with a debounce time of 1 seconds (1000ms)
        line.setDebouncePeriod(1000);
        // Configure threshold for "greater than 2000 Lux"
        line.setReflectivityCallbackThreshold('>', 2000, 0);
    }
);

// Register threshold reached callback
line.on(Tinkerforge.BrickletLine.CALLBACK_REFLECTIVITY_REACHED,
    // Callback for reflectivity greater than 2000 Lux
    function(reflectivity) {
        console.log('Reflectivity: '+reflectivity);
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
