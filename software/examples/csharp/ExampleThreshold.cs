using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback for reflectivity greater than 2000
	static void ReachedCB(BrickletLine sender, int reflectivity)
	{
		System.Console.WriteLine("Reflectivity: " + reflectivity);
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLine line = new BrickletLine(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 seconds (1000ms)
		line.SetDebouncePeriod(1000);

		// Register threshold reached callback to function ReachedCB
		line.ReflectivityReached += ReachedCB;

		// Configure threshold for "greater than 2000"
		line.SetReflectivityCallbackThreshold('>', 2000, 0);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
