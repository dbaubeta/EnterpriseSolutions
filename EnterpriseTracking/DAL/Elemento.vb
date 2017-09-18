Public Class Elemento

    Dim DBH As New SqlHelper

    Public Sub AgregarPermiso(g As BE.Elemento, p As BE.Elemento, DVH As Long)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            ' Insert
            params(0) = DBH.CrearParametro("@P1", Long.Parse(g.ID))
            params(1) = DBH.CrearParametro("@P2", Long.Parse(p.ID))
            params(2) = DBH.CrearParametro("@P3", Long.Parse(DVH))

            Dim resultado As Long = DBH.Insert("INSERT INTO ElementoElemento(IDPadre, IDHijo ,DVH) VALUES(@P1,@P2,@P3);", params)

        Catch ex As Exception
        End Try


    End Sub

    Public Function Cargar(e As BE.Elemento) As BE.Elemento
        Cargar = Nothing
    End Function

    Public Sub Guardar(e As BE.Elemento)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            If IsNothing(e.ID) Or e.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", e.Descripcion)
                params(1) = DBH.CrearParametro("@P2", Int32.Parse(e.Tipo))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(e.DVH))

                Dim resultado As Long = DBH.Insert("INSERT INTO Elemento(Descripcion, tipo ,DVH) VALUES(@P1,@P2,@P3); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    e.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(3)
                params(0) = DBH.CrearParametro("@P1", Int32.Parse(e.ID))
                params(1) = DBH.CrearParametro("@P2", e.Descripcion)
                params(2) = DBH.CrearParametro("@P3", Int32.Parse(e.Tipo))
                params(3) = DBH.CrearParametro("@P4", Long.Parse(e.DVH))

                DBH.Update("update Elemento set Descripcion=@P2, tipo=@P3, DVH=@P4 where ID=@P1", params)

            End If
        Catch ex As Exception
        End Try
    End Sub

    Public Function ObtenerGrupos(e As BE.Elemento, u As BE.Usuario) As List(Of BE.Elemento)
        ObtenerGrupos = Nothing
    End Function

    Public Function ObtenerGrupos() As List(Of BE.Elemento)
        ObtenerGrupos = Nothing
    End Function

    Public Function ObtenerPermisos() As List(Of BE.Elemento)
        ObtenerPermisos = Nothing
    End Function

    Public Sub QuitarPermiso(g As BE.Elemento, p As BE.Elemento, u As BE.Usuario)

    End Sub



    Public Function ObtenerElementos(u As BE.Usuario) As List(Of BE.Elemento)

        Dim params(0) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select IDelemento as ID, e.Descripcion, e.Tipo, e.dvh from ElementoUsuario ee join elemento e on e.id = ee.IDelemento where ee.IDUsuario=@P1"
        Dim dt As DataTable
        Dim l As BE.Elemento
        Dim ll As New List(Of BE.Elemento)

        Try
            params(0) = DBH.CrearParametro("@P1", Int64.Parse(u.ID))

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Elemento
                l.ID = dr.Item("ID")
                l.Descripcion = dr.Item("Descripcion")
                l.Tipo = dr.Item("Tipo")
                l.DVH = dr.Item("DVH")
                ll.Add(l)
            Next

            Return ll
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function ObtenerElementos(e As BE.Elemento) As List(Of BE.Elemento)

        Dim params(0) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select IDHijo as ID, e.Descripcion, e.Tipo, e.dvh from ElementoElemento ee join elemento e on e.id = ee.IDHijo where ee.IDPadre=@P1"
        Dim dt As DataTable
        Dim l As BE.Elemento
        Dim ll As New List(Of BE.Elemento)

        Try
            params(0) = DBH.CrearParametro("@P1", Int64.Parse(e.ID))


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Elemento
                l.ID = dr.Item("ID")
                l.Descripcion = dr.Item("Descripcion")
                l.Tipo = dr.Item("Tipo")
                l.DVH = dr.Item("DVH")
                ll.Add(l)
            Next

            Return ll
        Catch ex As Exception
            Throw ex
        End Try

    End Function



End Class
