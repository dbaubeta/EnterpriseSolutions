Public Class Usuario



    Public Function ObtenerUsuarios() As List(Of BE.Usuario)
        Dim d As New DAL.Usuario
        Try
            Return d.ObtenerUsuarios()
        Catch ex As Exception
            Throw ex
        End Try

    End Function

End Class
