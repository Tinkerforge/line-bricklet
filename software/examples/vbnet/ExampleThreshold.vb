Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for reflectivity greater than 2000
    Sub ReflectivityReachedCB(ByVal sender As BrickletLine, ByVal reflectivity As Integer)
        System.Console.WriteLine("Reflectivity: " + reflectivity.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim l As New BrickletLine(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 1 second (1000ms)
        l.SetDebouncePeriod(1000)

        ' Register threshold reached callback to function ReflectivityReachedCB
        AddHandler l.ReflectivityReached, AddressOf ReflectivityReachedCB

        ' Configure threshold for "greater than 2000"
        l.SetReflectivityCallbackThreshold(">"C, 2000, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
