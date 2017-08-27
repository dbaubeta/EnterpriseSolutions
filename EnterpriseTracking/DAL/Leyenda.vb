﻿Imports System.Data.SqlClient
Imports System.Data
Public Class Leyenda


    Public Sub Guardar_Leyendas(i As BE.Idioma)
        Dim DBH As New SqlHelper
        Dim params(3) As System.Data.SqlClient.SqlParameter

        For Each l As BE.Leyenda In i.Leyendas

            params(0) = DBH.CrearParametro("@P1", Int32.Parse(i.ID))
            params(1) = DBH.CrearParametro("@P2", l.ID)
            params(2) = DBH.CrearParametro("@P3", l.texto_Leyenda)
            params(3) = DBH.CrearParametro("@P4", Long.Parse(l.DVH))

            DBH.Insert("INSERT INTO Idioma_Leyenda(IDIdioma,IDLeyenda,Texto,DVH) VALUES(@P1,@P2,@P3,@P4)", params)

        Next

    End Sub

    Public Function ObtenerLeyendas(i As BE.Idioma) As List(Of BE.Leyenda)
        Dim DBH As New SqlHelper
        Dim params(0) As System.Data.SqlClient.SqlParameter
        Dim dt As DataTable
        Dim l As BE.Leyenda
        Dim ll As New List(Of BE.Leyenda)

        params(0) = DBH.CrearParametro("@P1", Int32.Parse(i.ID))
        dt = DBH.SelectTabla("select * from idioma_leyenda where IDIdioma=@P1", params)
        For Each dr As DataRow In dt.Rows
            l = New BE.Leyenda
            l.ID = dr.Item("IDLeyenda")
            l.texto_Leyenda = dr.Item("Texto")
            l.DVH = dr.Item("DVH")
            ll.Add(l)
        Next

        ObtenerLeyendas = ll
    End Function

    Public Function ObtenerLeyendas(i As BE.Idioma, m As BE.MensajeError) As BE.Leyenda
        Dim DBH As New SqlHelper
        Dim params(1) As System.Data.SqlClient.SqlParameter
        Dim dt As DataTable
        Dim l As New BE.Leyenda

        params(0) = DBH.CrearParametro("@P1", Int32.Parse(i.ID))
        params(1) = DBH.CrearParametro("@P2", m.IDError)
        dt = DBH.SelectTabla("select * from idioma_leyenda where IDIdioma=@P1 and IDLeyenda=@P2", params)
        For Each dr As DataRow In dt.Rows
            l = New BE.Leyenda
            l.ID = dr.Item("IDLeyenda")
            l.texto_Leyenda = dr.Item("Texto")
            l.DVH = dr.Item("DVH")
        Next

        ObtenerLeyendas = l
    End Function


End Class
