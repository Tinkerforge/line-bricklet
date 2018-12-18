package main

import (
	"fmt"
	"github.com/tinkerforge/go-api-bindings/ipconnection"
	"github.com/tinkerforge/go-api-bindings/line_bricklet"
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

	// Get current reflectivity.
	reflectivity, _ := l.GetReflectivity()
	fmt.Printf("Reflectivity: \n", reflectivity)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
