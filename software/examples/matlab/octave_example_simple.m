function octave_example_simple
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "mQH"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    line = java_new("com.tinkerforge.BrickletLine", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current reflectivity
    reflectivity = line.getReflectivity();

    fprintf("Reflectivity: %g\n", reflectivity);

    input("\nPress any key to exit...\n", "s");
    ipcon.disconnect();
end
