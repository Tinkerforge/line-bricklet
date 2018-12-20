use std::{io, error::Error};
use std::thread;
use tinkerforge::{ip_connection::IpConnection, 
                  line_bricklet::*};


const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Line Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let l = LineBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
    // Don't use device before ipcon is connected.

		// Get threshold receivers with a debounce time of 1 second (1000ms).
		l.set_debounce_period(1000);

     let reflectivity_reached_receiver = l.get_reflectivity_reached_callback_receiver();

        // Spawn thread to handle received callback messages. 
        // This thread ends when the `l` object
        // is dropped, so there is no need for manual cleanup.
        thread::spawn(move || {
            for reflectivity_reached in reflectivity_reached_receiver {           
                		println!("Reflectivity: {}", reflectivity_reached);
            }
        });

		// Configure threshold for reflectivity "greater than 2000".
		l.set_reflectivity_callback_threshold('>', 2000, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
