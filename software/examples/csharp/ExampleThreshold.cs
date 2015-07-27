using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for reflectivity greater than 2000
	static void ReflectivityReachedCB(BrickletLine sender, int reflectivity)
	{
		System.Console.WriteLine("Reflectivity: " + reflectivity);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLine l = new BrickletLine(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 second (1000ms)
		l.SetDebouncePeriod(1000);

		// Register threshold reached callback to function ReflectivityReachedCB
		l.ReflectivityReached += ReflectivityReachedCB;

		// Configure threshold for "greater than 2000"
		l.SetReflectivityCallbackThreshold('>', 2000, 0);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
