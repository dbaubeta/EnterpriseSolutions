	Public Class Factura

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Factura)

        Dim params(6) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE Factura AS target " +
                    "USING (SELECT @P1 as NroFactura,@P2 as Fecha,@P3 as DVH,@P4 as Borrado,@P5 as IDPuntoVenta,@P6 as IDDistribuidor,@P7 as IDVendedor) AS source " +
                    "ON target.NroFactura = source.NroFactura AND target.IDDistribuidor = source.IDDistribuidor " +
                    "WHEN NOT MATCHED THEN " +
                    "INSERT (NroFactura " +
                          ",Fecha " +
                          ",DVH " +
                          ",Borrado " +
                          ",IDPuntoVenta " +
                          ",IDDistribuidor " +
                          ",IDVendedor) " +
                    "VALUES " +
                          "(source.NroFactura " +
                          ",source.Fecha " +
                          ",source.DVH " +
                          ",source.Borrado " +
                          ",source.IDPuntoVenta " +
                          ",source.IDDistribuidor " +
                          ",source.IDVendedor) " +
                    "WHEN MATCHED THEN " +
                    "    UPDATE SET " +
                          "NroFactura = source.NroFactura " +
                          ",Fecha = source.Fecha " +
                          ",DVH = source.DVH " +
                          ",Borrado = source.Borrado " +
                          ",IDPuntoVenta = source.IDPuntoVenta " +
                          ",IDDistribuidor = source.IDDistribuidor " +
                          ",IDVendedor = source.IDVendedor;"



            ' Merge
            params(0) = DBH.CrearParametro("@P1", u.Nro_Factura_Real)
            params(1) = DBH.CrearParametro("@P2", u.Fecha)
            params(2) = DBH.CrearParametro("@P3", Long.Parse(u.DVH))
            params(3) = DBH.CrearParametro("@P4", u.borrado)
            params(4) = DBH.CrearParametro("@P5", Long.Parse(u.PuntoVenta.ID))
            params(5) = DBH.CrearParametro("@P6", Long.Parse(u.Distribuidor.ID))
            params(6) = DBH.CrearParametro("@P7", Long.Parse(u.Vendedor.ID))

            DBH.Update(cmd, params)
            u.ID = DBH.RetrieveScalar("select id from Factura where IDdistribuidor= " + u.Distribuidor.ID.ToString + " and NroFactura='" + u.Nro_Factura_Real + "'")

            Dim del As String = "delete from FacturaDetalle where IDFactura = " + u.ID.ToString
            DBH.Delete(del)


        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub

    Public Function ObtenerFacturas(Desde As BE.Factura, hasta As BE.Factura, Optional LazyLoad As Boolean = False) As List(Of BE.Factura)
        Dim params(2) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select * from Factura where borrado = 0 and IDDistribuidor = @P1 and cast(Fecha as date) >= cast(@P2 as date) and cast(Fecha as date) <= cast(@P3 as date)"
        Dim dt As DataTable
        Dim l As BE.Factura
        Dim ll As New List(Of BE.Factura)
        Dim dd As New DAL.Distribuidor
        Dim dp As New DAL.PuntodeVenta
        Dim dv As New DAL.Vendedor
        Try

            params(0) = DBH.CrearParametro("@P1", Desde.Distribuidor.ID)
            params(1) = DBH.CrearParametro("@P2", Desde.Fecha)
            params(2) = DBH.CrearParametro("@P3", hasta.Fecha)

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Factura
                l.ID = dr.Item("ID")
                l.Nro_Factura_Real = dr.Item("NroFactura")
                l.borrado = dr.Item("borrado")
                l.Fecha = dr.Item("Fecha")
                l.DVH = dr.Item("DVH")

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                If Not LazyLoad Then
                    Dim li As New List(Of BE.ABM)
                    li.Add(l.Distribuidor)
                    l.Distribuidor = dd.ObtenerLista(li)(0)
                End If

                l.PuntoVenta.ID = dr.Item("IDPuntoVenta")
                If Not LazyLoad Then
                    Dim lp As New List(Of BE.PuntodeVenta)
                    lp.Add(l.PuntoVenta)
                    l.PuntoVenta = dp.ObtenerPDVs(lp)(0)
                End If

                If Not LazyLoad Then
                    l.Vendedor.ID = dr.Item("IDVendedor")
                    Dim lv As New List(Of BE.Vendedor)
                    lv.Add(l.Vendedor)
                    l.Vendedor = dv.ObtenerVendedores(lv)(0)
                End If

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
