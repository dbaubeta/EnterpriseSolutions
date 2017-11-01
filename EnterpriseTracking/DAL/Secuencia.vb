	Public Class Secuencia

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Secuencia)

        Dim params(4) As System.Data.SqlClient.SqlParameter

        Try
            ' Insert
            params(0) = DBH.CrearParametro("@P1", Long.Parse(u.Nro_Secuencia_Real))
            params(1) = DBH.CrearParametro("@P2", u.Fecha)
            params(2) = DBH.CrearParametro("@P3", u.Estado)
            params(3) = DBH.CrearParametro("@P4", Long.Parse(u.DVH))
            params(4) = DBH.CrearParametro("@P5", Long.Parse(u.Distribuidor.ID))
            Dim resultado As Long = DBH.Insert("INSERT INTO Secuencia (IDReal,Fecha,Estado,DVH,IDDistribuidor) VALUES(@P1, @P2, @P3, @P4, @P5); SELECT SCOPE_IDENTITY();", params)
            If resultado <> -1 Then
                u.ID = resultado
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


		Public Function ObtenerSecuencias(ByVal f As List( Of BE.Secuencia)) As List( Of BE.Secuencia)
			ObtenerSecuencias = Nothing
		End Function


	End Class 

