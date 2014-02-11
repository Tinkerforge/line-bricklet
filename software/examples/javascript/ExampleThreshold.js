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
);//Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        //Get threshold callbacks with a debounce time of 1 seconds (1000ms)
        line.setDebouncePeriod(1000);
        //Configure threshold for "greater than 2000 Lux"
        line.setReflectivityCallbackThreshold('>', 2000, 0);
    }
);

//Register threshold reached callback
line.on(BrickletLine.CALLBACK_REFLECTIVITY_REACHED,
    //Callback for reflectivity greater than 2000 Lux
    function(reflectivity) {
        console.log('Reflectivity: '+reflectivity);
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

