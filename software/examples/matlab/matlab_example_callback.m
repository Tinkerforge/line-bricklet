function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLine;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Line Bricklet

    ipcon = IPConnection(); % Create IP connection
    l = handle(BrickletLine(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register reflectivity callback to function cb_reflectivity
    set(l, 'ReflectivityCallback', @(h, e) cb_reflectivity(e));

    % Set period for reflectivity callback to 1s (1000ms)
    % Note: The reflectivity callback is only called every second
    %       if the reflectivity has changed since the last call!
    l.setReflectivityCallbackPeriod(1000);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for reflectivity callback
function cb_reflectivity(e)
    fprintf('Reflectivity: %i\n', e.reflectivity);
end
