import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletLine;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Line Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLine l = new BrickletLine(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 second (1000ms)
		l.setDebouncePeriod(1000);

		// Add reflectivity reached listener
		l.addReflectivityReachedListener(new BrickletLine.ReflectivityReachedListener() {
			public void reflectivityReached(int reflectivity) {
				System.out.println("Reflectivity: " + reflectivity);
			}
		});

		// Configure threshold for reflectivity "greater than 2000"
		l.setReflectivityCallbackThreshold('>', 2000, 0);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
