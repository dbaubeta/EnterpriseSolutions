﻿Public Class Bitacora

    Dim DBH As New SqlHelper


    Public Sub Guardar(b As BE.Bitacora)

        Dim params(5) As System.Data.SqlClient.SqlParameter
        Try
            If IsNothing(b.ID) Or b.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", b.FechaHora)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(b.DVH))
                params(2) = DBH.CrearParametro("@P3", b.Mensaje)
                params(3) = DBH.CrearParametro("@P4", b.Modulo)
                params(4) = DBH.CrearParametro("@P5", b.Datos)
                params(5) = DBH.CrearParametro("@P6", Long.Parse(b.IDUsuario))

                Dim resultado As Long = DBH.Insert("INSERT INTO EntradasBitacora(FechaHora, DVH, mensaje, Modulo, Datos, IDUsuario) VALUES(@P1,@P2, @P3, @P4, @P5, @P6); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    b.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(6)
                params(0) = DBH.CrearParametro("@P1", b.FechaHora)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(b.DVH))
                params(2) = DBH.CrearParametro("@P3", b.Mensaje)
                params(3) = DBH.CrearParametro("@P4", b.Modulo)
                params(4) = DBH.CrearParametro("@P5", b.Datos)
                params(5) = DBH.CrearParametro("@P6", Long.Parse(b.IDUsuario))
                params(6) = DBH.CrearParametro("@P0", b.ID)

                DBH.Update("update EntradasBitacora set FechaHora=@P1, DVH=@P2, mensaje=@P3, Modulo=@P4, Datos=@P5, IDUsuario=@P6 where ID=@P0", params)

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

    Public Function ObtenerEntradas(f As List(Of BE.Bitacora)) As List(Of BE.Bitacora)


        Dim params(1) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select * from entradasbitacora where fechahora between @P1 and @P2 order by id desc"
        Dim idx As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Bitacora
        Dim ll As New List(Of BE.Bitacora)

        params(0) = DBH.CrearParametro("@P1", f.Item(0).FechaHora)
        params(1) = DBH.CrearParametro("@P2", f.Item(1).FechaHora)

        Try

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Bitacora
                l.ID = dr.Item("ID")
                l.DVH = dr.Item("DVH")
                l.FechaHora = dr.Item("Fechahora")
                l.IDUsuario = dr.Item("IDUsuario")
                l.Modulo = dr.Item("Modulo")
                l.Mensaje = dr.Item("Mensaje")
                l.Datos = dr.Item("Datos")
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
