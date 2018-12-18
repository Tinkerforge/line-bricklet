package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
	"github.com/Tinkerforge/go-api-bindings/line_bricklet"
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

	// Get threshold receivers with a debounce time of 1 second (1000ms).
	l.SetDebouncePeriod(1000)

	l.RegisterReflectivityReachedCallback(func(reflectivity uint16) {
		fmt.Printf("Reflectivity: %d\n", reflectivity)
	})

	// Configure threshold for reflectivity "greater than 2000".
	l.SetReflectivityCallbackThreshold('>', 2000, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
