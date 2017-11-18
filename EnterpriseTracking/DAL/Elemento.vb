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

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub

    Public Sub Guardar(e As BE.Elemento)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            If IsNothing(e.ID) Or e.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", e.nombre)
                params(1) = DBH.CrearParametro("@P2", Int32.Parse(e.Tipo))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(e.DVH))

                Dim resultado As Long = DBH.Insert("INSERT INTO Elemento(nombre, tipo ,DVH) VALUES(@P1,@P2,@P3); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    e.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(3)
                params(0) = DBH.CrearParametro("@P1", Int32.Parse(e.ID))
                params(1) = DBH.CrearParametro("@P2", e.nombre)
                params(2) = DBH.CrearParametro("@P3", Int32.Parse(e.Tipo))
                params(3) = DBH.CrearParametro("@P4", Long.Parse(e.DVH))

                DBH.Update("update Elemento set nombre=@P2, tipo=@P3, DVH=@P4 where ID=@P1", params)

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

    Public Sub Eliminar(e As BE.Elemento)

        Dim params(0) As System.Data.SqlClient.SqlParameter

        Try
            If Not (IsNothing(e.ID)) And e.ID <> 0 Then

                params(0) = DBH.CrearParametro("@P1", Int32.Parse(e.ID))

                DBH.Delete("delete from UsuarioElemento where IDElemento=@P1", params)
                DBH.Delete("delete from ElementoElemento where IDHijo=@P1", params)
                DBH.Delete("delete from ElementoElemento where IDPadre=@P1", params)
                DBH.Delete("delete from Elemento where ID=@P1", params)

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

    Public Function ObtenerElementos(i As List(Of BE.Elemento)) As List(Of BE.Elemento)

        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim in1 As String = ""
        Dim in2 As String = ""
        Dim cadena As String = "select * from Elemento "
        Dim idx1 As Integer = 0
        Dim idx2 As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Elemento
        Dim ll As New List(Of BE.Elemento)
        Dim di As New DAL.Idioma
        Dim c As New Cifrado.Cifrado


        Try

            If Not IsNothing(i) Then
                ReDim params(i.Count - 1)

                If i.Count > 0 Then

                    cadena = cadena + " where "
                    For Each x As BE.Elemento In i
                        If Not IsNothing(x.ID) And x.ID <> 0 Then
                            idx2 += 1
                            If idx2 > 1 Then in2 += "," Else in2 += " ID in ("
                            in2 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, x.ID)
                        ElseIf Not IsNothing(x.nombre) Then
                            idx1 += 1
                            If idx1 > 1 Then in1 += "," Else in1 += " nombre in ("
                            in1 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, c.Encriptar_str(x.nombre))
                        End If
                    Next
                    cadena += IIf(idx1 > 0, in1 + ")", "") + IIf(idx1 > 0 And idx2 > 0, " or ", "") + IIf(idx2 > 0, in2 + ")", "")
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Elemento
                l.ID = dr.Item("ID")
                l.nombre = dr.Item("Nombre")
                l.Tipo = dr.Item("Tipo")
                l.DVH = dr.Item("DVH")
                ll.Add(l)
            Next

            Return ll
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try



    End Function


    Public Function ObtenerGrupos() As List(Of BE.Elemento)

        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim cadena As String = "select ID, nombre, tipo , dvh from Elemento where Tipo=1 order by id"
        Dim dt As DataTable
        Dim l As BE.Elemento
        Dim ll As New List(Of BE.Elemento)

        Try
            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Elemento
                l.ID = dr.Item("ID")
                l.nombre = dr.Item("nombre")
                l.Tipo = dr.Item("Tipo")
                l.DVH = dr.Item("DVH")
                ll.Add(l)
            Next

            Return ll
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ObtenerPermisos() As List(Of BE.Elemento)

        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim cadena As String = "select ID, nombre, tipo , dvh from Elemento where Tipo=0 order by id"
        Dim dt As DataTable
        Dim l As BE.Elemento
        Dim ll As New List(Of BE.Elemento)

        Try
            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Elemento
                l.ID = dr.Item("ID")
                l.nombre = dr.Item("nombre")
                l.Tipo = dr.Item("Tipo")
                l.DVH = dr.Item("DVH")
                ll.Add(l)
            Next

            Return ll
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ObtenerElementos(u As BE.Usuario) As List(Of BE.Elemento)

        Dim params(0) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select IDelemento as ID, e.nombre, e.Tipo, e.dvh from UsuarioElemento ee join elemento e on e.id = ee.IDelemento where ee.IDUsuario=@P1"
        Dim dt As DataTable
        Dim l As BE.Elemento
        Dim ll As New List(Of BE.Elemento)

        Try
            params(0) = DBH.CrearParametro("@P1", Int64.Parse(u.ID))

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Elemento
                l.ID = dr.Item("ID")
                l.nombre = dr.Item("nombre")
                l.Tipo = dr.Item("Tipo")
                l.DVH = dr.Item("DVH")
                ll.Add(l)
            Next

            Return ll
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ObtenerHijos(e As BE.Elemento) As List(Of BE.Elemento)

        Dim params(0) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select IDHijo as ID, e.nombre, e.Tipo, e.dvh from ElementoElemento ee join elemento e on e.id = ee.IDHijo where ee.IDPadre=@P1"
        Dim dt As DataTable
        Dim l As BE.Elemento
        Dim ll As New List(Of BE.Elemento)

        Try
            params(0) = DBH.CrearParametro("@P1", Int64.Parse(e.ID))


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Elemento
                l.ID = dr.Item("ID")
                l.nombre = dr.Item("nombre")
                l.Tipo = dr.Item("Tipo")
                l.DVH = dr.Item("DVH")
                ll.Add(l)
            Next

            Return ll
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
