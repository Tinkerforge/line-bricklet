var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var l = new Tinkerforge.BrickletLine(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Get threshold callbacks with a debounce time of 1 second (1000ms)
        l.setDebouncePeriod(1000);

        // Configure threshold for reflectivity "greater than 2000"
        l.setReflectivityCallbackThreshold('>', 2000, 0);
    }
);

// Register reflectivity reached callback
l.on(Tinkerforge.BrickletLine.CALLBACK_REFLECTIVITY_REACHED,
    // Callback function for reflectivity reached callback
    function (reflectivity) {
        console.log('Reflectivity: ' + reflectivity);
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
