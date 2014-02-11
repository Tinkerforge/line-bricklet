var IPConnection = require('Tinkerforge/IPConnection');
var BrickletLine = require('Tinkerforge/BrickletLine');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'j6q';// Change to your UID

var ipcon = new IPConnection();// Create IP connection
var line = new BrickletLine(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        if(error === IPConnection.ERROR_ALREADY_CONNECTED) {
            console.log('Error: Already connected');        
        }
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        //Get current reflectivity
        line.getReflectivity(
            function(reflectivity) {
                console.log('Reflectivity: '+reflectivity);
            },
            function(error) {
                if(error === IPConnection.ERROR_TIMEOUT) {
                  console.log('Error: The request timed out');
                }
            }
        );
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data', function(data) {
	    ipcon.disconnect(
            function(error) {
                if(error === IPConnection.ERROR_NOT_CONNECTED) {
                    console.log('Error: Not connected');        
                }
            }
        );
process.exit(0);
});

