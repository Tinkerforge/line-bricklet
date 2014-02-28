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
        // Set Period for reflectivity callback to 1s (1000ms)
        // Note: The reflectivity callback is only called every second if the
        // reflectivity has changed since the last call!
        line.setReflectivityCallbackPeriod(1000);
    }
);

// Register reflectivity callback
line.on(Tinkerforge.BrickletLine.CALLBACK_REFLECTIVITY,
    // Callback function for reflectivity
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
