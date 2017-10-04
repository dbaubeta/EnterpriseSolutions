Public Class Bitacora

    Dim DBH As New SqlHelper

    Public Function Cargar(b As BE.Bitacora) As BE.Bitacora

        Return Nothing
    End Function

    Public Sub Guardar(b As BE.Bitacora)

        Dim params(5) As System.Data.SqlClient.SqlParameter
        Try
            ' Insert
            params(0) = DBH.CrearParametro("@P1", b.FechaHora)
            params(1) = DBH.CrearParametro("@P2", Long.Parse(b.DVH))
            params(2) = DBH.CrearParametro("@P3", b.Mensaje)
            params(3) = DBH.CrearParametro("@P4", b.Modulo)
            params(4) = DBH.CrearParametro("@P5", b.Datos)
            params(5) = DBH.CrearParametro("@P6", Long.Parse(b.IDUsuario))

            Dim resultado As Long = DBH.Insert("INSERT INTO EntradasBitacora(FechaHora, DVH, mensaje, Modulo, Datos, IDUsuario) VALUES(@P1,@P2, @P3, @P4, @P5, @P6); SELECT SCOPE_IDENTITY();", params)
            If resultado <> -1 Then
                b.ID = resultado
            End If

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Function ObtenerEntradas(f As List(Of BE.Bitacora)) As List(Of BE.Bitacora)
        ObtenerEntradas = Nothing
    End Function

End Class
