Imports System.Globalization
Imports System.Data
Imports System.Data.SqlClient

Public Class BackupRestore

    Dim DBH As New SqlHelper

    Public Sub Backup(b As BE.BROperation)


        Dim bkpcmd As String
        b.Path = My.Resources.BackupFolder + "Backup_EnterpriseSolutionsDB_" + b.Fecha.ToString("yyyy-MM-dd HH_mm_ss") + ".bkp"
        bkpcmd = "BACKUP DATABASE EnterpriseSolutionsBD TO  DISK = '" + b.Path + "' WITH INIT, SKIP , DESCRIPTION = 'Backup', NAME = 'EnterpriseSolutionsBD' "
        Dim cmd As New SqlCommand
        cmd.CommandType = CommandType.Text
        cmd.CommandText = bkpcmd
        cmd.Connection = DBH.ObtenerConexionMaster()

        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()
        cmd.Dispose()


    End Sub


    Public Sub Restore(b As BE.BROperation)


        Dim dsccmd As String = "DECLARE @ProcessId varchar(4) " + Environment.NewLine + _
                   "DECLARE CurrentProcesses SCROLL CURSOR FOR" + Environment.NewLine + _
                   "select spid from sysprocesses where dbid = (select dbid from sysdatabases where name = 'EnterpriseSolutionsBD' ) order by spid " + Environment.NewLine + _
                   "FOR READ ONLY" + Environment.NewLine + _
                   "OPEN CurrentProcesses" + Environment.NewLine + _
                   "FETCH NEXT FROM CurrentProcesses INTO @ProcessId" + Environment.NewLine + _
                   "WHILE @@FETCH_STATUS <> -1" + Environment.NewLine + _
                   "BEGIN" + Environment.NewLine + _
                   "	Exec ('KILL ' +  @ProcessId)" + Environment.NewLine + _
                   "	FETCH NEXT FROM CurrentProcesses INTO @ProcessId" + Environment.NewLine + _
                   "                    End" + Environment.NewLine + _
                   "CLOSE CurrentProcesses" + Environment.NewLine + _
                   "DeAllocate CurrentProcesses"


        Dim cmd As New SqlCommand
        cmd.CommandType = CommandType.Text
        cmd.CommandText = dsccmd
        cmd.Connection = DBH.ObtenerConexionMaster()

        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()

        Dim rstcmd As String
        b.Path = My.Resources.BackupFolder + "\Backup_EnterpriseSolutionsDB_" + b.Fecha.ToString("yyyy-MM-dd HH_mm_ss") + ".bkp"
        rstcmd = "RESTORE DATABASE EnterpriseSolutionsBD FROM DISK = '" + b.Path + "' WITH REPLACE, RECOVERY "
        cmd.CommandText = rstcmd

        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()
        cmd.Dispose()


    End Sub

    Public Function Obtener_Backups() As List(Of BE.BROperation)

        Dim cadena As String = "create table #tempdir(archivo varchar(1000), depth int, esarchivo int) " + Environment.NewLine + _
                                "insert into #tempdir EXEC xp_dirtree '" + My.Resources.BackupFolder + "', 1, 1" + Environment.NewLine + _
                                "select archivo from #tempdir where archivo like 'Backup_EnterpriseSolutionsDB%'"
        Dim idx As Integer = 0
        Dim dt As DataTable
        Dim l As BE.BROperation
        Dim ll As New List(Of BE.BROperation)

        Try

            dt = DBH.SelectTabla(cadena)
            For Each dr As DataRow In dt.Rows
                l = New BE.BROperation
                l.Path = My.Resources.BackupFolder + dr.Item("Archivo")
                l.Fecha = DateTime.ParseExact(dr.Item("Archivo").replace("Backup_EnterpriseSolutionsDB_", "").replace(".bkp", ""), "yyyy-MM-dd HH_mm_ss", CultureInfo.InvariantCulture)
                ll.Add(l)
            Next

            Return ll
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Sub Eliminar(b As BE.BROperation)


        Dim cmd As New SqlCommand
        cmd.CommandType = CommandType.Text
        cmd.Connection = DBH.ObtenerConexionMaster()

        Dim rstcmd As String
        b.Path = My.Resources.BackupFolder + "Backup_EnterpriseSolutionsDB_" + b.Fecha.ToString("yyyy-MM-dd HH_mm_ss") + ".bkp"
        rstcmd = "EXEC sp_configure 'show advanced options', 1;" + Environment.NewLine + _
                 "RECONFIGURE" + Environment.NewLine + _
                 "EXEC sp_configure 'xp_cmdshell',1" + Environment.NewLine + _
                 "RECONFIGURE" + Environment.NewLine + _
                 "EXEC xp_cmdshell 'DEL """ + b.Path + """'"

        cmd.CommandText = rstcmd

        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()
        cmd.Dispose()



    End Sub


End Class
