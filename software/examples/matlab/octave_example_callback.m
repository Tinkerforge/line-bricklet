function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Line Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    l = javaObject("com.tinkerforge.BrickletLine", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register reflectivity callback to function cb_reflectivity
    l.addReflectivityCallback(@cb_reflectivity);

    % Set period for reflectivity callback to 1s (1000ms)
    % Note: The reflectivity callback is only called every second
    %       if the reflectivity has changed since the last call!
    l.setReflectivityCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for reflectivity callback
function cb_reflectivity(e)
    fprintf("Reflectivity: %d\n", e.reflectivity);
end
