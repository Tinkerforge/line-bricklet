function octave_example_callback()
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "mQH"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    line = java_new("com.tinkerforge.BrickletLine", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for reflectivity callback to 1s (1000ms)
    % Note: The reflectivity callback is only called every second if the 
    %       reflectivity has changed since the last call!
    line.setReflectivityCallbackPeriod(1000);

    % Register reflectivity callback to function cb_reflectivity
    line.addReflectivityCallback(@cb_reflectivity);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for humidity callback (parameter has unit %RH/10)
function cb_reflectivity(e)
    fprintf("Reflectivity: %g\n", e.reflectivity);
end
