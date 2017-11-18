Imports System.Data
Imports System.Data.SqlClient


Public Class BackupRestore

    Dim DBH As New DAL.SqlHelper

    Public Sub Backup(b As BE.BROperation)
        Try
            Dim d As New DAL.BackupRestore
            d.Backup(b)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub


    Public Sub Restore(b As BE.BROperation)

        Try
            Dim d As New DAL.BackupRestore
            d.Restore(b)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub


    Public Sub Eliminar(b As BE.BROperation)

        Try
            Dim d As New DAL.BackupRestore
            d.Eliminar(b)
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try
    End Sub

    Public Function Obtener_Backups() As List(Of BE.BROperation)

        Try
            Dim d As New DAL.BackupRestore
            Return d.Obtener_Backups
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
