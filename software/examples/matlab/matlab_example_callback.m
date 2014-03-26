function matlab_example_callback
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLine;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'mQH'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    line = BrickletLine(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for reflectivity callback to 1s (1000ms)
    % Note: The reflectivity callback is only called every second if the 
    %       reflectivity has changed since the last call!
    line.setReflectivityCallbackPeriod(1000);

    % Register reflectivity callback to function cb_reflectivity
    set(line, 'ReflectivityCallback', @(h, e)cb_reflectivity(e.reflectivity));

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for humidity callback (parameter has unit %RH/10)
function cb_reflectivity(reflectivity_value)
    fprintf('Reflectivity: %g\n', reflectivity_value);
end
