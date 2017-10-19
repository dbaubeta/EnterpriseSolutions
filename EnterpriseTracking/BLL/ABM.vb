Public MustInherit Class ABM



    Protected d As DAL.ABM
    Dim DVH As New Digitos.Digito_Horizontal
    Dim DVV As New Digitos.Digito_Vertical


    Public Sub Eliminar(o As BE.ABM)
        Try
            o.borrado = True
            Guardar(o)

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
            ob.DVH = DVH.calcular(ob)
            d.Guardar(ob)
            DVV.tabla = "Cliente"
            DVV.calcular()

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Overridable Function ObtenerLista(Optional f As List(Of BE.ABM) = Nothing) As List(Of BE.ABM)

        Try
            Return d.ObtenerLista(f)

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Overridable Function ObtenerListaUsuario(u As BE.Usuario) As List(Of BE.ABM)

        Try
            Return d.ObtenerListaUsuario(u)

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public MustOverride Function ValidarDatos(ByVal p As BE.ABM) As List(Of BE.MensajeError)


End Class