Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Line Bricklet

    ' Callback subroutine for reflectivity reached callback
    Sub ReflectivityReachedCB(ByVal sender As BrickletLine, _
                              ByVal reflectivity As Integer)
        Console.WriteLine("Reflectivity: " + reflectivity.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim l As New BrickletLine(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 1 second (1000ms)
        l.SetDebouncePeriod(1000)

        ' Register reflectivity reached callback to subroutine ReflectivityReachedCB
        AddHandler l.ReflectivityReached, AddressOf ReflectivityReachedCB

        ' Configure threshold for reflectivity "greater than 2000"
        l.SetReflectivityCallbackThreshold(">"C, 2000, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
