	Public Class Detalle_Factura

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Detalle_Factura)


        Dim params(5) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE FacturaDetalle AS target " +
                    "USING (SELECT @P1 as IDFactura ,@P2 as Linea ,@P3 as IDProducto ,@P4 as Cantidad ,@P5 as precio ,@P6 as DVH ) AS source " +
                    "ON target.IDFactura = source.IDFactura AND target.linea = source.linea " +
                    "WHEN NOT MATCHED THEN " +
                    "INSERT (IDFactura " +
                            ",Linea " +
                            ",IDProducto " +
                            ",Cantidad " +
                            ",Precio " +
                            ",DVH) " +
                    "VALUES " +
                           "(source.IDFactura " +
                            ",source.Linea " +
                            ",source.IDProducto " +
                            ",source.Cantidad " +
                            ",source.Precio " +
                            ",source.DVH) " +
                    "WHEN MATCHED THEN " +
                    "    UPDATE SET " +
                           "IDFactura = source.IDFactura " +
                            ",Linea = source.Linea " +
                            ",IDProducto = source.IDProducto " +
                            ",Cantidad = source.Cantidad " +
                            ",Precio = source.Precio " +
                            ",DVH = source.DVH;"


            ' Merge
            params(0) = DBH.CrearParametro("@P1", Long.Parse(u.FacturaID))
            params(1) = DBH.CrearParametro("@P2", Long.Parse(u.Linea))
            params(2) = DBH.CrearParametro("@P3", Long.Parse(u.Producto.ID))
            params(3) = DBH.CrearParametro("@P4", Long.Parse(u.Cantidad))
            params(4) = DBH.CrearParametro("@P5", Double.Parse(u.Precio))
            params(5) = DBH.CrearParametro("@P6", Long.Parse(u.DVH))

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

    Public Function ObtenerDetalles(f As BE.Factura) As List(Of BE.Detalle_Factura)
        Dim params(0) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select fd.* from FacturaDetalle fd join factura f on f.id = fd.IDFactura where f.borrado = 0 and f.NroFactura = @P1 "
        Dim dt As DataTable
        Dim l As BE.Detalle_Factura
        Dim ll As New List(Of BE.Detalle_Factura)
        Dim dd As New DAL.Producto
        Try

            params(0) = DBH.CrearParametro("@P1", f.Nro_Factura_Real)

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Detalle_Factura

                l.FacturaID = dr.Item("IDFactura")
                l.Linea = dr.Item("linea")
                l.Cantidad = dr.Item("cantidad")
                l.Precio = dr.Item("precio")
                l.DVH = dr.Item("DVH")

                l.Producto.ID = dr.Item("IDProducto")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Producto)
                l.Producto = dd.ObtenerLista(li)(0)

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


    Public Function ObtenerDetalles(desde As BE.Factura, hasta As BE.Factura, Optional prod As BE.Producto = Nothing) As List(Of BE.Detalle_Factura)
        Dim params(2) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select fd.* from FacturaDetalle fd join factura f on f.id = fd.IDFactura where f.borrado = 0 and cast(Fecha as date) >= cast(@P1 as date) and cast(Fecha as date) <= cast(@P2 as date) and f.IDDistribuidor = @P3 "
        Dim dt As DataTable
        Dim l As BE.Detalle_Factura
        Dim ll As New List(Of BE.Detalle_Factura)
        Dim dd As New DAL.Producto
        Try
            If Not IsNothing(prod) Then
                ReDim params(3)
                params(0) = DBH.CrearParametro("@P1", desde.Fecha)
                params(1) = DBH.CrearParametro("@P2", hasta.Fecha)
                params(2) = DBH.CrearParametro("@P3", desde.Distribuidor.ID)
                params(3) = DBH.CrearParametro("@P4", prod.ID)
                cadena += " and IDProducto = @P4"
            Else
                params(0) = DBH.CrearParametro("@P1", desde.Fecha)
                params(1) = DBH.CrearParametro("@P2", hasta.Fecha)
                params(2) = DBH.CrearParametro("@P3", desde.Distribuidor.ID)
            End If
            cadena += " order by fecha"

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Detalle_Factura

                l.FacturaID = dr.Item("IDFactura")
                l.Linea = dr.Item("linea")
                l.Cantidad = dr.Item("cantidad")
                l.Precio = dr.Item("precio")
                l.DVH = dr.Item("DVH")

                l.Producto.ID = dr.Item("IDProducto")
                Dim li As New List(Of BE.ABM)
                li.Add(l.Producto)
                l.Producto = dd.ObtenerLista(li)(0)

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

    Public Function ObtenerDetallescomoStock(desde As BE.Factura, hasta As BE.Factura, Optional prod As BE.Producto = Nothing) As List(Of BE.Stock)
        Dim params(2) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select fd.*, f.fecha, f.IDDistribuidor from FacturaDetalle fd join factura f on f.id = fd.IDFactura where f.borrado = 0 and cast(Fecha as date) >= cast(@P1 as date) and cast(Fecha as date) <= cast(@P2 as date) and f.IDDistribuidor = @P3 "
        Dim dt As DataTable
        Dim l As BE.Stock
        Dim ll As New List(Of BE.Stock)
        Dim dd As New DAL.Producto
        Dim ddi As New DAL.Distribuidor
        Try
            If Not IsNothing(prod) Then
                ReDim params(3)
                params(0) = DBH.CrearParametro("@P1", desde.Fecha)
                params(1) = DBH.CrearParametro("@P2", hasta.Fecha)
                params(2) = DBH.CrearParametro("@P3", desde.Distribuidor.ID)
                params(3) = DBH.CrearParametro("@P4", prod.ID)
                cadena += " and IDProducto = @P4"
            Else
                params(0) = DBH.CrearParametro("@P1", desde.Fecha)
                params(1) = DBH.CrearParametro("@P2", hasta.Fecha)
                params(2) = DBH.CrearParametro("@P3", desde.Distribuidor.ID)
            End If
            cadena += " order by fecha"

            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Stock

                l.Fecha = dr.Item("fecha")
                l.borrado = 0
                l.Cantidad = dr.Item("cantidad")
                l.Precio = dr.Item("precio")
                l.DVH = dr.Item("DVH")

                l.Producto.ID = dr.Item("IDProducto")
                'Dim li As New List(Of BE.ABM)
                'li.Add(l.Producto)
                'l.Producto = dd.ObtenerLista(li)(0)
                l.Tipo = "Salida"

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                'Dim ld As New List(Of BE.ABM)
                'ld.Add(l.Distribuidor)
                'l.Distribuidor = ddi.ObtenerLista(ld)(0)

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
