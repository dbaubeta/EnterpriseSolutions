Public Class Usuario

    Dim DBH As New SqlHelper


    Public Sub Guardar(u As BE.Usuario)

        Dim params(3) As System.Data.SqlClient.SqlParameter
        Dim c As New Cifrado.Cifrado

        Try
            If IsNothing(u.ID) Or u.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", c.Encriptar_str(u.Nombre))
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Idioma.ID))
                params(3) = DBH.CrearParametro("@P4", u.Password)
                Dim resultado As Long = DBH.Insert("INSERT INTO Usuario(Nombre ,DVH, IDIdioma, IntentosFallidos, Habilitado, password) VALUES(@P1,@P2, @P3, 0, 1, @P4); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    u.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(6)
                params(0) = DBH.CrearParametro("@P1", Int32.Parse(u.ID))
                params(1) = DBH.CrearParametro("@P2", c.Encriptar_str(u.Nombre))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.DVH))
                params(3) = DBH.CrearParametro("@P4", Long.Parse(u.Idioma.ID))
                params(4) = DBH.CrearParametro("@P5", Int32.Parse(u.Intentos_fallidos))
                params(5) = DBH.CrearParametro("@P6", Boolean.Parse(u.Habilitado))
                params(6) = DBH.CrearParametro("@P7", u.Password)

                DBH.Update("update Usuario set Nombre=@P2, DVH=@P3, IDIdioma=@P4, Intentosfallidos=@P5, Habilitado=@P6, password=@P7 where ID=@P1", params)

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

    Public Sub Eliminar(u As BE.Usuario)

        Dim params(0) As System.Data.SqlClient.SqlParameter

        Try
            If IsNothing(u.ID) Or u.ID = 0 Then
            Else
                'Delete
                params(0) = DBH.CrearParametro("@P1", Int32.Parse(u.ID))
                DBH.Delete("delete from Usuario where ID=@P1", params)

            End If

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Function ObtenerUsuarios() As List(Of BE.Usuario)


        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim cadena As String = "select * from usuario where borrado=0"
        Dim idx As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Usuario
        Dim ll As New List(Of BE.Usuario)
        Dim di As New DAL.Idioma
        Dim c As New Cifrado.Cifrado

        Try

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Usuario
                l.ID = dr.Item("ID")
                l.Nombre = c.Desencriptar_str(dr.Item("Nombre"))
                l.DVH = dr.Item("DVH")
                l.Idioma.ID = dr.Item("IDIdioma")
                Dim li As New List(Of BE.Idioma)
                li.Add(l.Idioma)
                l.Idioma = di.Obtener_Idiomas(li)(0)
                l.Intentos_fallidos = dr.Item("IntentosFallidos")
                l.Password = dr.Item("password")
                l.Habilitado = dr.Item("Habilitado")
                ll.Add(l)
            Next

            Return ll

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ObtenerUsuarios(i As List(Of BE.Usuario)) As List(Of BE.Usuario)


        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim in1 As String = ""
        Dim in2 As String = ""
        Dim cadena As String = "select * from usuario where "
        Dim idx1 As Integer = 0
        Dim idx2 As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Usuario
        Dim ll As New List(Of BE.Usuario)
        Dim di As New DAL.Idioma
        Dim c As New Cifrado.Cifrado


        Try

            If Not IsNothing(i) Then
                ReDim params(i.Count - 1)

                If i.Count > 0 Then


                    For Each x As BE.Usuario In i
                        If Not IsNothing(x.ID) And x.ID <> 0 Then
                            idx2 += 1
                            If idx2 > 1 Then in2 += "," Else in2 += " ID in ("
                            in2 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, x.ID)
                        ElseIf Not IsNothing(x.Nombre) Then
                            idx1 += 1
                            If idx1 > 1 Then in1 += "," Else in1 += " nombre in ("
                            in1 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, c.Encriptar_str(x.Nombre))
                        End If
                    Next
                    cadena += IIf(idx1 > 0, in1 + ")", "") + IIf(idx1 > 0 And idx2 > 0, " or ", "") + IIf(idx2 > 0, in2 + ")", "")
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Usuario
                l.ID = dr.Item("ID")
                l.Nombre = c.Desencriptar_str(dr.Item("Nombre"))
                l.DVH = dr.Item("DVH")
                l.Idioma.ID = dr.Item("IDIdioma")
                Dim li As New List(Of BE.Idioma)
                li.Add(l.Idioma)
                l.Idioma = di.Obtener_Idiomas(li)(0)
                l.Intentos_fallidos = dr.Item("IntentosFallidos")
                l.Password = dr.Item("password")
                l.Habilitado = dr.Item("Habilitado")
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

    Public Sub Agregar_Elemento(u As BE.Usuario, p As BE.Elemento, DVH As Long)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            ' Insert
            params(0) = DBH.CrearParametro("@P1", Long.Parse(u.ID))
            params(1) = DBH.CrearParametro("@P2", Long.Parse(p.ID))
            params(2) = DBH.CrearParametro("@P3", Long.Parse(DVH))

            Dim resultado As Long = DBH.Insert("INSERT INTO UsuarioElemento(IDUsuario, IDElemento ,DVH) VALUES(@P1,@P2,@P3);", params)

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub


End Class
