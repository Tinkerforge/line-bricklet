import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletLine;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLine l = new BrickletLine(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set period for reflectivity callback to 1s (1000ms)
		// Note: The reflectivity callback is only called every second
		//       if the reflectivity has changed since the last call!
		l.setReflectivityCallbackPeriod(1000);

		// Add reflectivity listener
		l.addReflectivityListener(new BrickletLine.ReflectivityListener() {
			public void reflectivity(int reflectivity) {
				System.out.println("Reflectivity: " + reflectivity);
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
