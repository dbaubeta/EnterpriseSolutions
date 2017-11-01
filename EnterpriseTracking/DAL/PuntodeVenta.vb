Public Class PuntodeVenta

    Protected DBH As New SqlHelper

    Public Sub Guardar(s As List(Of BE.PuntodeVenta))

        Dim params(4) As System.Data.SqlClient.SqlParameter

        Try

            Dim cmd As String = "MERGE Vendedor AS target " + _
                    "USING (SELECT @P1 as IDReal, @P2 as Nombre, @P3 as DVH, @P4 as Borrado, @P5 as IDDistribuidor) AS source " + _
                    "ON target.IDReal = source.IDReal AND target.IDDistribuidor = source.IDDistribuidor " + _
                    "WHEN NOT MATCHED THEN " + _
                    "INSERT (IDReal " + _
                    "        ,Nombre " + _
                    "        ,DVH " + _
                    "        ,Borrado " + _
                    "        ,IDDistribuidor) " + _
                    "VALUES " + _
                    "        (source.IDReal " + _
                    "        ,source.Nombre " + _
                    "        ,source.DVH " + _
                    "        ,source.Borrado " + _
                    "        ,source.IDDistribuidor) " + _
                    "WHEN MATCHED THEN " + _
                    "    UPDATE SET " + _
                    "        IDReal = source.IDReal " + _
                    "       ,Nombre = source.Nombre " + _
                    "       ,DVH = source.DVH " + _
                    "       ,Borrado = source.Borrado " + _
                    "       ,IDDistribuidor = source.IDDistribuidor;"

            For Each u As BE.PuntodeVenta In s

                ' Merge
                params(0) = DBH.CrearParametro("@P1", u.IDReal)
                params(1) = DBH.CrearParametro("@P2", u.Nombre)
                params(2) = DBH.CrearParametro("@P3", Long.Parse(u.DVH))
                params(3) = DBH.CrearParametro("@P4", u.borrado)
                params(4) = DBH.CrearParametro("@P5", Long.Parse(u.Distribuidor.ID))

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

    Public Function ObtenerPDVs(ByVal f As List(Of BE.PuntodeVenta)) As List(Of BE.PuntodeVenta)

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

                l.Distribuidor.ID = dr.Item("IDDistribuidor")
                Dim lc As New List(Of BE.ABM)
                lc.Add(l.Distribuidor)
                l.Distribuidor = dc.ObtenerLista(lc)(0)

                l.Provincia.ID = dr.Item("IDProvincia")
                Dim lp As New List(Of BE.Provincia)
                lp.Add(l.Provincia)
                l.Provincia = dp.Obtenerprovincias(lp)(0)

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
