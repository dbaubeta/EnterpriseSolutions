	Public Class Detalle_Factura

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Detalle_Factura)


        Dim params(11) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE PuntoDeVenta AS target " + _
                    "USING (SELECT @P1 as IDReal ,@P2 as Nombre ,@P3 as CUIT ,@P4 as Calle ,@P5 as Depto ,@P6 as CodigoPostal ,@P7 as DVH ,@P8 as Borrado ,@P9 as IDProvincia ,@P10 as IDDistribuidor ,@P11 as IDVendedor ,@P12 as Numero) AS source " + _
                    "ON target.IDReal = source.IDReal AND target.IDDistribuidor = source.IDDistribuidor " + _
                    "WHEN NOT MATCHED THEN " + _
                    "INSERT (IDFactura " + _
                            ",Linea " + _
                            ",IDProducto " + _
                            ",Cantidad " + _
                            ",Precio " + _
                            ",DVH) " + _
                    "VALUES " + _
                           "(source.IDFactura " + _
                            ",source.Linea " + _
                            ",source.IDProducto " + _
                            ",source.Cantidad " + _
                            ",source.Precio " + _
                            ",source.DVH) " + _
                    "WHEN MATCHED THEN " + _
                    "    UPDATE SET " + _
                           "IDFactura = source.IDFactura " + _
                            ",Linea = source.Linea " + _
                            ",IDProducto = source.IDProducto " + _
                            ",Cantidad = source.Cantidad " + _
                            ",Precio = source.Precio " + _
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

    Public Function ObtenerDetalles(f As List(Of BE.Factura)) As List(Of BE.Detalle_Factura)
        ObtenerDetalles = Nothing
    End Function


	End Class 
