	Public Class Factura

    Protected DBH As New SqlHelper

    Public Sub Guardar(u As BE.Factura)

        Dim params(6) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE PuntoDeVenta AS target " + _
                    "USING (SELECT @P1 as NroFactura,@P2 as Fecha,@P3 as DVH,@P4 as Borrado,@P5 as IDPuntoVenta,@P6 as IDDistribuidor,@P7 as IDVendedor) AS source " + _
                    "ON target.IDReal = source.IDReal AND target.IDDistribuidor = source.IDDistribuidor " + _
                    "WHEN NOT MATCHED THEN " + _
                    "INSERT (NroFactura " + _
                          ",Fecha " + _
                          ",DVH " + _
                          ",Borrado " + _
                          ",IDPuntoVenta " + _
                          ",IDDistribuidor " + _
                          ",IDVendedor) " + _
                    "VALUES " + _
                          "(source.NroFactura " + _
                          ",source.Fecha " + _
                          ",source.DVH " + _
                          ",source.Borrado " + _
                          ",source.IDPuntoVenta " + _
                          ",source.IDDistribuidor " + _
                          ",source.IDVendedor) " + _
                    "WHEN MATCHED THEN " + _
                    "    UPDATE SET " + _
                          "NroFactura = source.NroFactura " + _
                          ",Fecha = source.Fecha " + _
                          ",DVH = source.DVH " + _
                          ",Borrado = source.Borrado " + _
                          ",IDPuntoVenta = source.IDPuntoVenta " + _
                          ",IDDistribuidor = source.IDDistribuidor " + _
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


        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub

		Public Function ObtenerFacturas(ByVal f As List(Of BE.Factura)) As List(Of BE.Factura)
			ObtenerFacturas = Nothing
		End Function


	End Class 
