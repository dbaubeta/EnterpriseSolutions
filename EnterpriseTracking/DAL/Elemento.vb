Public Class Elemento
    Dim DBH As New SqlHelper

    Public Sub AgregarPermiso(ByVal g As BE.Elemento, ByVal p As BE.Elemento, ByVal u As BE.Usuario)

    End Sub

    Public Function Cargar(ByVal e As BE.Elemento) As BE.Elemento
        Cargar = Nothing
    End Function

    Public Sub Guardar(ByVal e As BE.Elemento)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            ' Insert
            params(0) = DBH.CrearParametro("@P1", e.Descripcion)
            params(1) = DBH.CrearParametro("@P2", Int32.Parse(e.Tipo))
            params(2) = DBH.CrearParametro("@P3", Long.Parse(e.DVH))

            Dim resultado As Long = DBH.Insert("INSERT INTO Elemento(Descripcion, tipo ,DVH) VALUES(@P1,@P2,@P3); SELECT SCOPE_IDENTITY();", params)
            If resultado <> -1 Then
                e.ID = resultado
            End If

        Catch ex As Exception
        End Try
    End Sub

    Public Function ObtenerGrupos(ByVal e As BE.Elemento, ByVal u As BE.Usuario) As List(Of BE.Elemento)
        ObtenerGrupos = Nothing
    End Function

    Public Function ObtenerGrupos() As List(Of BE.Elemento)
        ObtenerGrupos = Nothing
    End Function

    Public Function ObtenerPermisos() As List(Of BE.Elemento)
        ObtenerPermisos = Nothing
    End Function

    Public Sub QuitarPermiso(ByVal g As BE.Elemento, ByVal p As BE.Elemento, ByVal u As BE.Usuario)

    End Sub



    Public Function ObtenerElementos(u As BE.Usuario) As List(Of BE.Elemento)

        Dim params(0) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select IDelemento as ID, e.Descripcion, e.Tipo, e.dvh from Elemento_Usuario ee join elemento e on e.id = ee.IDelemento where ee.IDUsuario=@P1"
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
        Dim cadena As String = "select IDHijo as ID, e.Descripcion, e.Tipo, e.dvh from elemento_elemento ee join elemento e on e.id = ee.IDHijo where ee.IDPadre=@P1"
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
