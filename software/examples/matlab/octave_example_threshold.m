function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Line Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    l = javaObject("com.tinkerforge.BrickletLine", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 second (1000ms)
    l.setDebouncePeriod(1000);

    % Register reflectivity reached callback to function cb_reflectivity_reached
    l.addReflectivityReachedCallback(@cb_reflectivity_reached);

    % Configure threshold for reflectivity "greater than 2000"
    l.setReflectivityCallbackThreshold(">", 2000, 0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for reflectivity reached callback
function cb_reflectivity_reached(e)
    fprintf("Reflectivity: %d\n", e.reflectivity);
end
