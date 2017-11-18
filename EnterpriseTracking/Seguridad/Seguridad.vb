Public Class Seguridad

    Public Function ObtenerGrupo(ByVal o As BE.Elemento) As Grupo
        Dim u As New Grupo

        Try
            u.Elemento = o
            u.Cargar()

            If IsNothing(u.Elemento) Then Return Nothing

            Return u

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ObtenerGrupos() As List(Of Grupo)
        '    Public Function ObtenerUsuarios() As List(Of BE.Usuario)
        Dim d As New DAL.Elemento
        Dim l As New List(Of Grupo)

        Try

            For Each bu As BE.Elemento In d.ObtenerGrupos()
                Dim x As New Grupo
                x.Elemento = bu
                l.Add(x)
            Next

            Return l
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ObtenerPermisos() As List(Of Permiso)
        Dim d As New DAL.Elemento
        Dim l As New List(Of Permiso)
        Try

            For Each bu As BE.Elemento In d.ObtenerPermisos()
                Dim x As New Permiso
                x.Elemento = bu
                l.Add(x)
            Next

            Return l
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try
    End Function

    Public Function ObtenerUsuario(ByVal o As BE.Usuario) As Usuario

        Dim u As New Usuario

        Try
            u.Usuario = o
            u.Cargar()

            If IsNothing(u.Usuario) Then Return Nothing

            Return u

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ObtenerUsuarios() As List(Of Usuario)
        Dim d As New DAL.Usuario
        Dim l As New List(Of Usuario)
        Try

            For Each bu As BE.Usuario In d.ObtenerUsuarios()
                Dim x As New Usuario
                x = ObtenerUsuario(bu)
                l.Add(x)
            Next

            Return l
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function


    Public Function ObtenerUsuariosSinAsignar() As List(Of Usuario)
        Dim d As New DAL.Usuario
        Dim l As New List(Of Usuario)
        Try

            For Each bu As BE.Usuario In d.ObtenerUsuariosSinAsignar()
                Dim x As New Usuario
                x = ObtenerUsuario(bu)
                l.Add(x)
            Next

            Return l
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
