Public Class Justificacion

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Justificacion)

        Dim params(6) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE justificacion AS target " +
                    "USING (SELECT @P1 as Nrojustificacion,@P2 as Fecha,@P3 as DVH,@P4 as Borrado,@P5 as IDPuntoVenta,@P6 as IDDistribuidor,@P7 as IDVendedor) AS source " +
                    "ON target.Nrojustificacion = source.Nrojustificacion AND target.IDDistribuidor = source.IDDistribuidor " +
                    "WHEN NOT MATCHED THEN " +
                    "INSERT (Nrojustificacion " +
                          ",Fecha " +
                          ",DVH " +
                          ",Borrado " +
                          ",IDPuntoVenta " +
                          ",IDDistribuidor " +
                          ",IDVendedor) " +
                    "VALUES " +
                          "(source.Nrojustificacion " +
                          ",source.Fecha " +
                          ",source.DVH " +
                          ",source.Borrado " +
                          ",source.IDPuntoVenta " +
                          ",source.IDDistribuidor " +
                          ",source.IDVendedor) " +
                    "WHEN MATCHED THEN " +
                    "    UPDATE SET " +
                          "Nrojustificacion = source.Nrojustificacion " +
                          ",Fecha = source.Fecha " +
                          ",DVH = source.DVH " +
                          ",Borrado = source.Borrado " +
                          ",IDPuntoVenta = source.IDPuntoVenta " +
                          ",IDDistribuidor = source.IDDistribuidor " +
                          ",IDVendedor = source.IDVendedor;"



            ' Merge
            params(0) = DBH.CrearParametro("@P1", u.Nro_justificacion_Real)
            params(1) = DBH.CrearParametro("@P2", u.Fecha)
            params(2) = DBH.CrearParametro("@P3", Long.Parse(u.DVH))
            params(3) = DBH.CrearParametro("@P4", u.borrado)
            params(4) = DBH.CrearParametro("@P5", Long.Parse(u.PuntoVenta.ID))
            params(5) = DBH.CrearParametro("@P6", Long.Parse(u.Distribuidor.ID))
            params(6) = DBH.CrearParametro("@P7", Long.Parse(u.Vendedor.ID))

            DBH.Update(cmd, params)

            u.ID = DBH.RetrieveScalar("select id from justificacion where IDdistribuidor= " + u.Distribuidor.ID.ToString + " and Nrojustificacion='" + u.Nro_justificacion_Real + "'")

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub

    Public Function Obtenerjustificacions(ByVal f As List(Of BE.Justificacion)) As List(Of BE.Justificacion)
        Obtenerjustificacions = Nothing
    End Function

    Public Function Obtenerjustificacions(Desde As BE.Justificacion, hasta As BE.Justificacion) As List(Of BE.Justificacion)
        Dim params(2) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select * from justificacion where borrado = 0 and IDDistribuidor = @P1 and cast(Fecha as date) >= cast(@P2 as date) and cast(Fecha as date) <= cast(@P3 as date)"
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
                l.Nro_justificacion_Real = dr.Item("Nrojustificacion")
                l.borrado = dr.Item("borrado")
                l.Fecha = dr.Item("Fecha")
                l.DVH = dr.Item("DVH")

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Distribuidor)
                l.Distribuidor = dd.ObtenerLista(li)(0)

                l.PuntoVenta.ID = dr.Item("IDPuntoVenta")
                Dim lp As New List(Of BE.PuntodeVenta)
                lp.Add(l.PuntoVenta)
                l.PuntoVenta = dp.ObtenerPDVs(lp)(0)

                l.Vendedor.ID = dr.Item("IDVendedor")
                Dim lv As New List(Of BE.Vendedor)
                lv.Add(l.Vendedor)
                l.Vendedor = dv.ObtenerVendedores(lv)(0)


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
