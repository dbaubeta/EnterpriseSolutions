Public Class Justificacion

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Justificacion)

        Dim params(3) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE justificacion AS target " +
                    "USING (SELECT @P1 as IDDistribuidor,@P2 as Fecha,@P3 as DVH,@P4 as motivo) AS source " +
                    "ON target.IDDistribuidor = source.IDDistribuidor AND target.Fecha = source.Fecha " +
                    "WHEN NOT MATCHED THEN " +
                    "INSERT (IdDistribuidor " +
                          ",Fecha " +
                          ",DVH " +
                          ",motivo) " +
                    "VALUES " +
                          "(source.IDDistribuidor " +
                          ",source.Fecha " +
                          ",source.DVH " +
                          ",source.motivo) " +
                    "WHEN MATCHED THEN " +
                    "    UPDATE SET " +
                          "IDDistribuidor = source.IDDistribuidor " +
                          ",Fecha = source.Fecha " +
                          ",DVH = source.DVH " +
                          ",motivo = source.motivo;"



            ' Merge
            params(0) = DBH.CrearParametro("@P1", u.Distribuidor.ID)
            params(1) = DBH.CrearParametro("@P2", u.Fecha)
            params(2) = DBH.CrearParametro("@P3", Long.Parse(u.DVH))
            params(3) = DBH.CrearParametro("@P4", u.Motivo)

            DBH.Update(cmd, params)

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub


    Public Sub Eliminar(u As BE.Justificacion)

        Dim params(1) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "delete from justificacion " +
                    "where IDDistribuidor = @P1 AND cast(Fecha as date) = cast(@P2 as date);"

            ' Eliminar
            params(0) = DBH.CrearParametro("@P1", u.Distribuidor.ID)
            params(1) = DBH.CrearParametro("@P2", u.Fecha)

            DBH.Delete(cmd, params)

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub



    Public Function Obtenerjustificaciones(ByVal f As List(Of BE.Justificacion)) As List(Of BE.Justificacion)
        Obtenerjustificaciones = Nothing
    End Function

    Public Function Obtenerjustificaciones(Desde As BE.Justificacion, hasta As BE.Justificacion) As List(Of BE.Justificacion)
        Dim params(2) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select * from justificacion where IDDistribuidor = @P1 and cast(Fecha as date) >= cast(@P2 as date) and cast(Fecha as date) <= cast(@P3 as date)"
        Dim dt As DataTable
        Dim l As BE.Justificacion
        Dim ll As New List(Of BE.Justificacion)
        Dim dd As New DAL.Distribuidor
        Dim dp As New DAL.PuntodeVenta
        Dim dv As New DAL.Vendedor
        Try

            params(0) = DBH.CrearParametro("@P1", Desde.Distribuidor.ID)
            params(1) = DBH.CrearParametro("@P2", Desde.Fecha)
            params(2) = DBH.CrearParametro("@P3", hasta.Fecha)

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Justificacion
                l.ID = dr.Item("ID")
                l.Fecha = dr.Item("Fecha")
                l.DVH = dr.Item("DVH")
                l.Motivo = dr.Item("motivo")

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Distribuidor)
                l.Distribuidor = dd.ObtenerLista(li)(0)

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
