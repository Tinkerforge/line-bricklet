using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for reflectivity
	static void ReflectivityCB(BrickletLine sender, int reflectivity)
	{
		System.Console.WriteLine("Reflectivity: " + reflectivity);
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLine line = new BrickletLine(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set Period for reflectivity callback to 1s (1000ms)
		// Note: The reflectivity callback is only called every second if the 
		//       reflectivity has changed since the last call!
		line.SetReflectivityCallbackPeriod(1000);

		// Register reflectivity callback to function ReflectivityCB
		line.Reflectivity += ReflectivityCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
