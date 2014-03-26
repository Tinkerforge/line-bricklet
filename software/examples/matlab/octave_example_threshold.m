function octave_example_threshold
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "mQH"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    line = java_new("com.tinkerforge.BrickletLine", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    line.setDebouncePeriod(1000);

    % Register threshold reached callback to function cb_reached
    line.addReflectivityReachedListener("cb_reached");
    
    % Configure threshold for "greater than 2000 Lux"
    line.setReflectivityCallbackThreshold(">", 2000, 0);

    input("\nPress any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback for reflectivity greater than 2000 Lux
function cb_reached(reflectivity_value)
    fprintf("Reflectivity: %g\n", reflectivity_value);
end
