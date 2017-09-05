Imports System.Data
Imports System.Data.SqlClient

Public Class Leyenda

    Dim _conn As SqlConnection

    Public Function ObtenerConexion() As SqlConnection

        If IsNothing(_conn) Then
            _conn = New SqlConnection("Server=localhost;Database=EnterpriseSolutionBD2015;Trusted_Connection=True;")
        End If

        Return _conn

    End Function

    Public Function ObtenerLeyendas(ByVal idioma As BE.Idioma, ByVal pantallas As List(Of BE.Pantalla)) As List(Of BE.Leyenda)

        Dim leyendas As New List(Of BE.Leyenda)
        'Dim conn As New SqlConnection()
        'conn = ObtenerConexion()
        'Dim sql As String = "select * from Sales.Orders where orderID = @orderID"
        'Dim cmdSQL As New SqlCommand(sql, conn)

        'cmdSQL.Parameters.Add(New SqlParameter("@orderID", SqlDbType.Int))
        'cmdSQL.Parameters("@orderID").Value = parsedOrderID

        '' try-catch-finally
        'Try
        '    ' Abrir connexion
        '    conn.Open()

        '    ' Ejecutar el comando.
        '    Dim rdr As SqlDataReader = cmdSQL.ExecuteReader()

        '    ' Crear una tabla para obtener el resultado
        '    Dim tabla As New DataTable()
        '    tabla.Load(rdr)

        '    ' Recorrer la tabla y generar la lista de salida


        '    rdr.Close()
        'Catch
        '    ' A simple catch.
        '    MessageBox.Show("The requested order could not be loaded into the form.")
        'Finally
        '    ' Close the connection.
        '    conn.Close()
        'End Try

        Return leyendas

    End Function

End Class

Public Function ObtenerLeyenda(ByVal idioma As BE.Idioma, ByVal control As be.Control) As BE.Leyenda

    Dim leyenda As New BE.Leyenda
    Dim conn As New SqlConnection()
    conn = ObtenerConexion()
    Dim sql As String = "select * from Sales.Orders where orderID = @orderID"
    Dim cmdSQL As New SqlCommand(sql, conn)

    cmdSQL.Parameters.Add(New SqlParameter("@orderID", SqlDbType.Int))
    cmdSQL.Parameters("@orderID").Value = parsedOrderID

    ' try-catch-finally
    Try
        ' Abrir connexion
        conn.Open()

        ' Ejecutar el comando.
        Dim rdr As SqlDataReader = cmdSQL.ExecuteReader()

        ' Crear una tabla para obtener el resultado
        Dim tabla As New DataTable()
        tabla.Load(rdr)

        ' Recorrer la tabla y generar la lista de salida


        rdr.Close()
    Catch
        ' A simple catch.
        MessageBox.Show("The requested order could not be loaded into the form.")
    Finally
        ' Close the connection.
        conn.Close()
    End Try

End Function

End Class
