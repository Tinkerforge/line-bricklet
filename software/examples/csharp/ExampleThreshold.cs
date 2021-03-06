using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Line Bricklet

	// Callback function for reflectivity reached callback
	static void ReflectivityReachedCB(BrickletLine sender, int reflectivity)
	{
		Console.WriteLine("Reflectivity: " + reflectivity);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLine l = new BrickletLine(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 second (1000ms)
		l.SetDebouncePeriod(1000);

		// Register reflectivity reached callback to function ReflectivityReachedCB
		l.ReflectivityReachedCallback += ReflectivityReachedCB;

		// Configure threshold for reflectivity "greater than 2000"
		l.SetReflectivityCallbackThreshold('>', 2000, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
