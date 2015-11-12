function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLine;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    l = handle(BrickletLine(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 second (1000ms)
    l.setDebouncePeriod(1000);

    % Register reflectivity reached callback to function cb_reflectivity_reached
    set(l, 'ReflectivityReachedCallback', @(h, e) cb_reflectivity_reached(e));

    % Configure threshold for reflectivity "greater than 2000"
    l.setReflectivityCallbackThreshold('>', 2000, 0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for reflectivity reached callback
function cb_reflectivity_reached(e)
    fprintf('Reflectivity: %i\n', e.reflectivity);
end
