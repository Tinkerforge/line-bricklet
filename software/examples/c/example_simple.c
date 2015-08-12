#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_line.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

int main(void) {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	Line l;
	line_create(&l, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		return 1;
	}
	// Don't use device before ipcon is connected

	// Get current reflectivity
	uint16_t reflectivity;
	if(line_get_reflectivity(&l, &reflectivity) < 0) {
		fprintf(stderr, "Could not get reflectivity, probably timeout\n");
		return 1;
	}

	printf("Reflectivity: %d\n", reflectivity);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
