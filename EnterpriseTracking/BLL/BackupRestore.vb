Imports System.Data
Imports System.Data.SqlClient


Public Class BackupRestore

    Dim DBH As New DAL.SqlHelper

    Public Sub Backup(b As BE.BROperation)

        Dim d As New DAL.Backup
        d.Backup(b)


    End Sub


    Public Sub Restore(b As BE.BROperation)

        Dim d As New DAL.Backup
        d.Restore(b)

    End Sub


    Public Sub Eliminar()

    End Sub

    Public Sub Grabar(ByVal o As BE.BROperation)

    End Sub

    Public Function Obtener_Backups() As List(Of BE.BROperation)

        Dim d As New DAL.Backup
        Return d.Obtener_Backups

    End Function




End Class
