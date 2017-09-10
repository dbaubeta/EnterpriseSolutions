﻿Public Class Usuario

    Private _elementos As List(Of Elemento)
    Public Property Elementos() As List(Of Elemento)
        Get
            Return _elementos
        End Get
        Set(ByVal value As List(Of Elemento))
            _elementos = value
        End Set
    End Property


    Private _Usuario As BE.Usuario
    Public Property Usuario() As BE.Usuario
        Get
            Return _Usuario
        End Get
        Set(ByVal value As BE.Usuario)
            _Usuario = value
        End Set
    End Property

    Public Sub Agregar_elemento(ByVal p_elemento As Elemento)
    End Sub


    Public Sub Bloquear_Usuario(ByVal u As BE.usuario)

    End Sub

    Public Sub Guardar(ByVal u As BE.Usuario)

    End Sub

    Public Sub Cargar()

        Dim l As New List(Of BE.Usuario)
        Dim d As New DAL.Usuario

        l.Add(Me.Usuario)
        l = d.ObtenerUsuarios(l)
        If l.Count > 0 Then
            Me.Usuario = l.Item(0)
            ' Cargar permisos aca


        Else
            Me.Usuario = Nothing
        End If


    End Sub


    Public Function ObtenerUsuarios(ByVal f As List(Of BE.Usuario)) As List(Of BE.Usuario)
        ObtenerUsuarios = Nothing
    End Function

    Public Function Usuario_Bloqueado(ByVal u As BE.Usuario) As List(Of BE.MensajeError)
        Usuario_Bloqueado = Nothing
    End Function

    Public Function ValidarDatos(ByVal s As BE.Usuario) As List(Of BE.MensajeError)
        ValidarDatos = Nothing
    End Function

    Public Function ValidarPassword(ByVal s As BE.Usuario) As List(Of BE.MensajeError)
        ValidarPassword = Nothing
    End Function

    Public Sub New()
        Me.Usuario = New BE.Usuario
        Me.Elementos = New List(Of Elemento)
    End Sub


End Class
