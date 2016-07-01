function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Line Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    l = java_new("com.tinkerforge.BrickletLine", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current reflectivity
    reflectivity = l.getReflectivity();
    fprintf("Reflectivity: %d\n", reflectivity);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
