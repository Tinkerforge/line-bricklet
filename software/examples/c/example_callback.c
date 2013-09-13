
#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_line.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback function for reflectivity 
void cb_reflectivity(uint16_t reflectivity, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Reflectivity: %d\n", reflectivity);
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	Line line;
	line_create(&line, UID, &ipcon); 

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Set Period for reflectivity callback to 1s (1000ms)
	// Note: The reflectivity callback is only called every second if the 
	//       reflectivity has changed since the last call!
	line_set_reflectivity_callback_period(&line, 1000);

	// Register reflectivity callback to function cb_reflectivity
	line_register_callback(&line,
	                       LINE_CALLBACK_REFLECTIVITY,
	                       (void *)cb_reflectivity,
	                       NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
