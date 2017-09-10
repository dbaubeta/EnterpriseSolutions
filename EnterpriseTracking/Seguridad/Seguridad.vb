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
        ObtenerUsuarios = Nothing
    End Function

End Class
