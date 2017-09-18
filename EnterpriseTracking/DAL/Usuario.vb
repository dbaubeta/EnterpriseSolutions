﻿Public Class Usuario

    Dim DBH As New SqlHelper

    Public Sub Guardar(u As BE.Usuario)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            If IsNothing(u.ID) Or u.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", u.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(u.DVH))
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Idioma.ID))

                Dim resultado As Long = DBH.Insert("INSERT INTO Usuario(Nombre ,DVH, IDIdioma, IntentosFallidos, Habilitado) VALUES(@P1,@P2, @P3, 0, 1); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    u.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(5)
                params(0) = DBH.CrearParametro("@P1", Int32.Parse(u.ID))
                params(1) = DBH.CrearParametro("@P2", u.Nombre)
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.DVH))
                params(3) = DBH.CrearParametro("@P4", Long.Parse(u.Idioma.ID))
                params(4) = DBH.CrearParametro("@P5", Int32.Parse(u.Intentos_fallidos))
                params(5) = DBH.CrearParametro("@P6", Boolean.Parse(u.Habilitado))

                DBH.Update("update Usuario set Nombre=@P2, DVH=@P3, IDIdioma=@P4, Intentosfallidos=@P5, Habilitado=@P6 where ID=@P1", params)

            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Public Function ObtenerUsuarios() As List(Of BE.Usuario)


        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim cadena As String = "select * from usuario"
        Dim idx As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Usuario
        Dim ll As New List(Of BE.Usuario)
        Dim di As New DAL.Idioma


        Try

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Usuario
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
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
        Catch ex As Exception
            Throw ex
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


        Try

            If Not IsNothing(i) Then
                ReDim params(i.Count - 1)

                If i.Count > 0 Then


                    For Each x As BE.Usuario In i
                        If Not IsNothing(x.Nombre) Then
                            idx1 += 1
                            If idx1 > 1 Then in1 += "," Else in1 += " nombre in ("
                            in1 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, x.Nombre)
                        ElseIf Not IsNothing(x.ID) Then
                            idx2 += 1
                            If idx2 > 1 Then in2 += "," Else in2 += " ID in ("
                            in2 += "@P" + (idx1 + idx2).ToString.Trim
                            params((idx1 + idx2) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2).ToString.Trim, x.ID)
                        End If
                    Next
                    cadena += IIf(idx1 > 0, in1 + ")", "") + IIf(idx1 > 0 And idx2 > 0, " or ", "") + IIf(idx2 > 0, in2 + ")", "")
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Usuario
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
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
        Catch ex As Exception
            Throw ex
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

        Catch ex As Exception
        End Try

    End Sub


End Class
