use std::{error::Error, io, thread};
use tinkerforge::{ipconnection::IpConnection, line_bricklet::*};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Line Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let line_bricklet = LineBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get threshold listeners with a debounce time of 1 second (1000ms)
    line_bricklet.set_debounce_period(1000);

    //Create listener for reflectivity reached events.
    let reflectivity_reached_listener = line_bricklet.get_reflectivity_reached_receiver();
    // Spawn thread to handle received events. This thread ends when the line_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in reflectivity_reached_listener {
            println!("Reflectivity: {}", event);
        }
    });

    // Configure threshold for reflectivity "greater than 2000"
    line_bricklet.set_reflectivity_callback_threshold('>', 2000, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
