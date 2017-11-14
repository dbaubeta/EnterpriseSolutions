Public Class Stock

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Stock)


        Dim params(7) As System.Data.SqlClient.SqlParameter

        Try

            'Dim del As String = "delete from StockDetalle where IDStock = '" + u.StockID.ToString + "'"

            Dim cmd As String = "MERGE stock AS target " +
                    "USING (SELECT @P1 as Fecha ,@P2 as Tipo ,@P3 as Cantidad ,@P4 as Precio ,@P5 as borrado ,@P6 as DVH, @P7 as IDDistribuidor ,@P8 as IDProducto ) AS source " +
                    "ON target.IDProducto = source.IDProducto AND target.fecha = source.fecha " +
                    "WHEN NOT MATCHED THEN " +
                    "INSERT (Fecha " +
                            ",Tipo " +
                            ",Cantidad " +
                            ",Precio " +
                            ",borrado " +
                            ",DVH " +
                            ",IDDistribuidor " +
                            ",IDProducto) " +
                    "VALUES " +
                           "(source.Fecha " +
                            ",source.Tipo " +
                            ",source.Cantidad " +
                            ",source.Precio " +
                            ",source.borrado " +
                            ",source.DVH " +
                            ",source.IDDistribuidor " +
                            ",source.IDProducto) " +
                    "WHEN MATCHED THEN " +
                    "    UPDATE SET " +
                           "Fecha = source.Fecha " +
                            ",Tipo = source.Tipo " +
                            ",Cantidad = source.Cantidad " +
                            ",borrado = source.borrado " +
                            ",DVH = source.DVH " +
                            ",Precio = source.Precio " +
                            ",IDDistribuidor = source.IDDistribuidor " +
                            ",IDProducto = source.IDProducto;"


            ' Merge
            params(0) = DBH.CrearParametro("@P1", u.Fecha)
            params(1) = DBH.CrearParametro("@P2", u.Tipo)
            params(2) = DBH.CrearParametro("@P3", u.Cantidad)
            params(3) = DBH.CrearParametro("@P4", u.Precio)
            params(4) = DBH.CrearParametro("@P5", u.borrado)
            params(5) = DBH.CrearParametro("@P6", u.DVH)
            params(6) = DBH.CrearParametro("@P7", u.Distribuidor.ID)
            params(7) = DBH.CrearParametro("@P8", u.Producto.ID)

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

    Public Function ObtenerStocks(Desde As BE.Stock, hasta As BE.Stock) As List(Of BE.Stock)
        Dim params(2) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select * from Stock where borrado = 0 and IDDistribuidor = @P1 and cast(Fecha as date) >= cast(@P2 as date) and cast(Fecha as date) <= cast(@P3 as date) order by fecha asc"
        Dim dt As DataTable
        Dim l As BE.Stock
        Dim ll As New List(Of BE.Stock)
        Dim dd As New DAL.Distribuidor
        Dim dp As New DAL.Producto
        Dim dv As New DAL.Vendedor
        Try

            params(0) = DBH.CrearParametro("@P1", Desde.Distribuidor.ID)
            params(1) = DBH.CrearParametro("@P2", Desde.Fecha)
            params(2) = DBH.CrearParametro("@P3", hasta.Fecha)

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Stock
                l.ID = dr.Item("ID")
                l.borrado = dr.Item("borrado")
                l.Fecha = dr.Item("Fecha")
                l.Cantidad = dr.Item("cantidad")
                l.Tipo = dr.Item("tipo")
                l.Precio = dr.Item("Precio")
                l.DVH = dr.Item("DVH")

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Distribuidor)
                l.Distribuidor = dd.ObtenerLista(li)(0)

                l.Producto.ID = dr.Item("IDProducto")
                Dim lp As New List(Of BE.ABM)
                lp.Add(l.Producto)
                l.Producto = dp.ObtenerLista(lp)(0)



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

    Public Function CalcularStock(desde As BE.Factura, hasta As BE.Factura, prod As BE.Producto) As BE.Stock
        Dim params(3) As System.Data.SqlClient.SqlParameter

        Dim cadena As String = "select COALESCE(sum(x.cantidad),0) as cantidad from ("
        cadena += "select (cantidad * (-1)) as cantidad from FacturaDetalle fd join factura f on f.id = fd.IDFactura where f.borrado = 0 and cast(Fecha as date) >= cast(@P1 as date) and cast(Fecha as date) <= cast(@P2 as date) and f.IDDistribuidor = @P3 and IDProducto = @P4 "
        cadena += "UNION ALL select case when tipo = 'Entrada' then cantidad else cantidad * (-1) end as cantidad from stock where borrado = 0 and cast(Fecha as date) >= cast(@P1 as date) and cast(Fecha as date) <= cast(@P2 as date) and IDDistribuidor = @P3 and IDProducto = @P4"
        cadena += ") as x"

        Dim l As New BE.Stock
        Try
            params(0) = DBH.CrearParametro("@P1", desde.Fecha)
            params(1) = DBH.CrearParametro("@P2", hasta.Fecha)
            params(2) = DBH.CrearParametro("@P3", desde.Distribuidor.ID)
            params(3) = DBH.CrearParametro("@P4", prod.ID)

            l.Cantidad = DBH.RetrieveScalar(cadena, params)
            Return l

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
