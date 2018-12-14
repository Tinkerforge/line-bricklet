package main

import (
	"fmt"
	"tinkerforge/ipconnection"
	"tinkerforge/line_bricklet"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Line Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	l, _ := line_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	l.RegisterReflectivityCallback(func(reflectivity uint16) {
		fmt.Printf("Reflectivity: %d\n", reflectivity)
	})

	// Set period for reflectivity receiver to 1s (1000ms).
	// Note: The reflectivity callback is only called every second
	//       if the reflectivity has changed since the last call!
	l.SetReflectivityCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
