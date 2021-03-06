﻿Public Class Permiso
    Inherits Elemento


    Public Overrides Sub Cargar()

        Dim l As New List(Of BE.Elemento)
        Dim du As New DAL.Elemento

        Try
            ' Cargar permiso
            ' =============================================================
            l.Add(Me.Elemento)
            l = du.ObtenerElementos(l)
            If l.Count > 0 Then
                Me.Elemento = l.Item(0)
            Else
                Me.Elemento = Nothing
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


    Public Overrides Function ObtenerPermisos() As List(Of Elemento)

        Dim l As New List(Of Elemento)
        l.Add(Me)

        Return l
    End Function


    Public Sub Guardar()

        Dim dvh As New Digitos.Digito_Horizontal
        Dim dvv As New Digitos.Digito_Vertical
        Try
            Dim d As New DAL.Elemento
            Me.Elemento.DVH = dvh.calcular(Me.Elemento)
            d.Guardar(Me.Elemento)
            dvv.tabla = "Elemento"
            dvv.calcular()
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Sub New()
        Me.Elemento = New BE.Elemento
    End Sub

End Class
