function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLine;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'mQH'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    line = BrickletLine(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current reflectivity
    reflectivity = line.getReflectivity();
    fprintf('Reflectivity: %g\n', reflectivity);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end
