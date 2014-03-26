function matlab_example_threshold
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLine;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'mQH'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    line = BrickletLine(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    line.setDebouncePeriod(1000);

    % Register threshold reached callback to function cb_reached
    set(line, 'ReflectivityReachedCallback', @(h, e)cb_reached(e.reflectivity));
    
    % Configure threshold for "greater than 2000 Lux"
    line.setReflectivityCallbackThreshold('>', 2000, 0);

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback for reflectivity greater than 2000 Lux
function cb_reached(reflectivity_value)
    fprintf('Reflectivity: %g\n', reflectivity_value);
end
