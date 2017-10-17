Public Class Provincia

    Public Function ObtenerProvincias(Optional f As List(Of BE.Provincia) = Nothing) As List(Of BE.Provincia)
        Dim d As New DAL.Provincia

        Try
            Return d.ObtenerProvincias(f)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Function


End Class 