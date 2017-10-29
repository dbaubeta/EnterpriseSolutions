Public Class Persistencia


    Dim abm As ABM

    Public Sub Eliminar(o As BE.ABM)

        Try
            abm.Eliminar(o)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Sub EstablecerObjetoNegocio(p As ABM)

        Try
            abm = p
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Sub Guardar(ob As BE.ABM)

        Try
            abm.Guardar(ob)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Function ObtenerLista(Optional f As List(Of BE.ABM) = Nothing) As List(Of BE.ABM)

        Try
            Return abm.ObtenerLista(f)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    'Public Function ObtenerListaUsuario(u As BE.Usuario) As List(Of BE.ABM)

    '    Try
    '        Return abm.ObtenerListaUsuario(u)
    '    Catch bex As BE.Excepcion
    '        Throw bex
    '    Catch ex As Exception
    '        Dim bex As New BE.Excepcion
    '        bex.Excepcion = ex
    '        bex.Capa = Me.GetType().ToString
    '        Throw bex
    '    End Try

    'End Function


    Public Function ValidarDatos(p As BE.ABM) As List(Of BE.MensajeError)

        Try
            Return abm.ValidarDatos(p)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function


    Public Sub New()

    End Sub

    Public Sub New(o As BLL.ABM)

        Me.abm = o

    End Sub

End Class