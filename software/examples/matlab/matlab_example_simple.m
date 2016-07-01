function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLine;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Line Bricklet

    ipcon = IPConnection(); % Create IP connection
    l = handle(BrickletLine(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current reflectivity
    reflectivity = l.getReflectivity();
    fprintf('Reflectivity: %i\n', reflectivity);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
