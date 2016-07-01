using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Line Bricklet

	// Callback function for reflectivity callback
	static void ReflectivityCB(BrickletLine sender, int reflectivity)
	{
		Console.WriteLine("Reflectivity: " + reflectivity);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLine l = new BrickletLine(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register reflectivity callback to function ReflectivityCB
		l.Reflectivity += ReflectivityCB;

		// Set period for reflectivity callback to 1s (1000ms)
		// Note: The reflectivity callback is only called every second
		//       if the reflectivity has changed since the last call!
		l.SetReflectivityCallbackPeriod(1000);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
