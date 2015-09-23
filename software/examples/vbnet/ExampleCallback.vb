Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback subroutine for reflectivity callback
    Sub ReflectivityCB(ByVal sender As BrickletLine, ByVal reflectivity As Integer)
        Console.WriteLine("Reflectivity: " + reflectivity.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim l As New BrickletLine(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register reflectivity callback to subroutine ReflectivityCB
        AddHandler l.Reflectivity, AddressOf ReflectivityCB

        ' Set period for reflectivity callback to 1s (1000ms)
        ' Note: The reflectivity callback is only called every second
        '       if the reflectivity has changed since the last call!
        l.SetReflectivityCallbackPeriod(1000)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
