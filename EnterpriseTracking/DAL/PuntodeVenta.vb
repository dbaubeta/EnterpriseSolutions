Public Class PuntodeVenta

    Protected DBH As New SqlHelper

    Public Sub Guardar(s As List(Of BE.PuntodeVenta))

        Dim params(13) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE PuntoDeVenta AS target " + _
                    "USING (SELECT @P1 as IDReal ,@P2 as Nombre ,@P3 as CUIT ,@P4 as Calle ,@P5 as Depto ,@P6 as CodigoPostal ,@P7 as DVH ,@P8 as Borrado ,@P9 as IDProvincia ,@P10 as IDDistribuidor ,@P11 as IDVendedor ,@P12 as Numero, @P13 as Latitud ,@P14 as Longitud) AS source " + _
                    "ON target.IDReal = source.IDReal AND target.IDDistribuidor = source.IDDistribuidor " + _
                    "WHEN NOT MATCHED THEN " + _
                    "INSERT (IDReal  " + _
                           ",Nombre " + _
                           ",CUIT " + _
                           ",Calle " + _
                           ",Depto " + _
                           ",CodigoPostal " + _
                           ",DVH " + _
                           ",Borrado " + _
                           ",IDProvincia " + _
                           ",IDDistribuidor " + _
                           ",IDVendedor " + _
                           ",Numero " + _
                           ",Latitud " + _
                           ",Longitud) " + _
                    "VALUES " + _
                           "(source.IDReal  " + _
                           ",source.Nombre " + _
                           ",source.CUIT " + _
                           ",source.Calle " + _
                           ",source.Depto " + _
                           ",source.CodigoPostal " + _
                           ",source.DVH " + _
                           ",source.Borrado " + _
                           ",source.IDProvincia " + _
                           ",source.IDDistribuidor " + _
                           ",source.IDVendedor " + _
                           ",source.Numero " + _
                           ",source.Latitud " + _
                           ",source.Longitud) " + _
                    "WHEN MATCHED THEN " + _
                    "    UPDATE SET " + _
                           "IDReal = source.IDReal  " + _
                           ",Nombre = source.Nombre " + _
                           ",CUIT = source.CUIT " + _
                           ",Calle = source.Calle " + _
                           ",Depto = source.Depto " + _
                           ",CodigoPostal = source.CodigoPostal " + _
                           ",DVH = source.DVH " + _
                           ",Borrado = source.Borrado " + _
                           ",IDProvincia = source.IDProvincia " + _
                           ",IDDistribuidor = source.IDDistribuidor " + _
                           ",IDVendedor = source.IDVendedor " + _
                           ",Numero = source.Numero " + _
                           ",Latitud = source.Latitud " + _
                           ",Longitud = source.Longitud;"

            For Each u As BE.PuntodeVenta In s

                ' Merge
                params(0) = DBH.CrearParametro("@P1", u.IDReal)
                params(1) = DBH.CrearParametro("@P2", u.Nombre)
                params(2) = DBH.CrearParametro("@P3", u.CUIT)
                params(3) = DBH.CrearParametro("@P4", u.Calle)
                params(4) = DBH.CrearParametro("@P5", u.Depto)
                params(5) = DBH.CrearParametro("@P6", u.CodigoPostal)
                params(6) = DBH.CrearParametro("@P7", Long.Parse(u.DVH))
                params(7) = DBH.CrearParametro("@P8", u.borrado)
                params(8) = DBH.CrearParametro("@P9", Long.Parse(u.Provincia.ID))
                params(9) = DBH.CrearParametro("@P10", Long.Parse(u.Distribuidor.ID))
                params(10) = DBH.CrearParametro("@P11", Long.Parse(u.Vendedor.ID))
                params(11) = DBH.CrearParametro("@P12", u.numero)
                params(12) = DBH.CrearParametro("@P13", u.Latitud)
                params(13) = DBH.CrearParametro("@P14", u.Longitud
                                                )


                DBH.Update(cmd, params)


            Next


        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try
    End Sub

    Public Function ObtenerPDVs(Optional f As List(Of BE.PuntodeVenta) = Nothing) As List(Of BE.PuntodeVenta)

        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim in1 As String = ""
        Dim in2 As String = ""
        Dim in3 As String = ""
        Dim cadena As String = "select * from PuntoDeVenta where borrado = 0 "
        Dim idx1 As Integer = 0
        Dim idx2 As Integer = 0
        Dim idx3 As Integer = 0
        Dim dt As DataTable
        Dim l As BE.PuntodeVenta
        Dim ll As New List(Of BE.PuntodeVenta)
        Dim dc As New DAL.Distribuidor
        Dim dp As New DAL.Provincia
        Dim dv As New DAL.Vendedor


        Try

            If Not IsNothing(f) Then
                ReDim params(f.Count - 1)

                If f.Count > 0 Then
                    cadena = cadena + " and ("
                    For Each x As BE.PuntodeVenta In f
                        If Not IsNothing(x.ID) And x.ID <> 0 Then
                            idx2 += 1
                            If idx2 > 1 Then in2 += "," Else in2 += " ID in ("
                            in2 += "@P" + (idx1 + idx2 + idx3).ToString.Trim
                            params((idx1 + idx2 + idx3) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2 + idx3).ToString.Trim, x.ID)
                        ElseIf Not IsNothing(x.IDReal) Then
                            idx3 += 1
                            If idx3 > 1 Then in3 += "," Else in3 += " IDReal in ("
                            in3 += "@P" + (idx1 + idx2 + idx3).ToString.Trim
                            params((idx1 + idx2 + idx3) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2 + idx3).ToString.Trim, x.IDReal)
                        ElseIf Not IsNothing(x.Nombre) Then
                            idx1 += 1
                            If idx1 > 1 Then in1 += "," Else in1 += " nombre in ("
                            in1 += "@P" + (idx1 + idx2 + idx3).ToString.Trim
                            params((idx1 + idx2 + idx3) - 1) = DBH.CrearParametro("@P" + (idx1 + idx2 + idx3).ToString.Trim, x.Nombre)
                        End If
                    Next
                    If idx1 > 0 Then
                        cadena += in1 + ")" + IIf(idx2 + idx3 > 0, " or ", "")
                    End If
                    If idx2 > 0 Then
                        cadena += in2 + ")" + IIf(idx3 > 0, " or ", "")
                    End If
                    If idx3 > 0 Then
                        cadena += in3 + ")"
                    End If

                    cadena += ")"
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.PuntodeVenta
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
                l.IDReal = dr.Item("IDReal")
                l.Calle = dr.Item("Calle")
                l.numero = dr.Item("numero")
                l.Depto = dr.Item("Depto")
                l.CodigoPostal = dr.Item("CodigoPostal")
                l.CUIT = dr.Item("CUIT")
                l.borrado = dr.Item("borrado")
                l.DVH = dr.Item("DVH")
                If dr.Item("Latitud") Is GetType(DBNull) Then
                    l.Latitud = Nothing
                Else
                    l.Latitud = dr.Item("Latitud")
                End If
                If dr.Item("Longitud") Is GetType(DBNull) Then
                    l.Longitud = Nothing
                Else
                    l.Longitud = dr.Item("Longitud")
                End If

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                Dim lc As New List(Of BE.ABM)
                lc.Add(l.Distribuidor)
                l.Distribuidor = dc.ObtenerLista(lc)(0)

                l.Provincia.ID = dr.Item("IDProvincia")
                Dim lp As New List(Of BE.Provincia)
                lp.Add(l.Provincia)
                l.Provincia = dp.ObtenerProvincias(lp)(0)

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
