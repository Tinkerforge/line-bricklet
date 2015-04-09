#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_line.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback for reflectivity greater than 2000
void cb_reached(uint16_t reflectivity, void *user_data) {
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

	// Get threshold callbacks with a debounce time of 1 seconds (1000ms)
	line_set_debounce_period(&line, 1000);

	// Register threshold reached callback to function cb_reached
	line_register_callback(&line,
	                       LINE_CALLBACK_REFLECTIVITY_REACHED,
	                       (void *)cb_reached,
	                       NULL);

	// Configure threshold for "greater than 2000"
	line_set_reflectivity_callback_threshold(&line, '>', 2000, 0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
