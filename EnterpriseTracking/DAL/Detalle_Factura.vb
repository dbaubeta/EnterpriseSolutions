	Public Class Detalle_Factura

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Detalle_Factura)


        Dim params(5) As System.Data.SqlClient.SqlParameter

        Try

            Dim del As String = "delete from FacturaDetalle where IDFactura = '" + u.FacturaID.ToString + "'"

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

            DBH.Delete(del)
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

    Public Function ObtenerDetalles(f As List(Of BE.Factura)) As List(Of BE.Detalle_Factura)
        ObtenerDetalles = Nothing
    End Function


	End Class 
