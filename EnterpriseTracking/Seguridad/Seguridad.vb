Public Class Seguridad

    Public Function ObtenerGrupo(ByVal o As BE.Elemento) As Grupo
        ObtenerGrupo = Nothing
    End Function

    Public Function ObtenerGrupos() As List(Of Grupo)
        ObtenerGrupos = Nothing
    End Function

    Public Function ObtenerPermiso(ByVal o As BE.Elemento) As Permiso
        ObtenerPermiso = Nothing
    End Function

    Public Function ObtenerPermisos() As List(Of Permiso)
        ObtenerPermisos = Nothing
    End Function

    Public Function ObtenerUsuario(ByVal o As BE.Usuario) As Usuario

        Dim u As New Usuario
        u.Usuario = o
        u.Cargar()

        If IsNothing(u.Usuario) Then Return Nothing

        Return u

    End Function

    Public Function ObtenerUsuarios() As List(Of Usuario)
        '    Public Function ObtenerUsuarios() As List(Of BE.Usuario)
        Dim d As New DAL.Usuario
        Dim l As New List(Of Usuario)
        Try

            For Each bu As BE.Usuario In d.ObtenerUsuarios()
                Dim x As New Usuario
                x = ObtenerUsuario(bu)
                l.Add(x)
            Next

            Return l
        Catch ex As Exception
            Throw ex
        End Try

        '   End Function
    End Function

End Class
