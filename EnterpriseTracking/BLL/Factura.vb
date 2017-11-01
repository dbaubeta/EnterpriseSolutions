Public Class Factura

    Dim d As New DAL.Factura
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical

    Public Sub Guardar(ob As BE.Secuencia)


        Dim bd As New BLL.Distribuidor
        Dim l As New List(Of BE.ABM)

        Dim bp As New BLL.PuntodeVenta
        Dim lp As New List(Of BE.PuntodeVenta)

        Dim bv As New BLL.Vendedor
        Dim lv As New List(Of BE.Vendedor)

        Dim bdf As New BLL.Detalle_Factura


        Try
            l.Add(ob.Distribuidor)
            ob.Distribuidor = bd.ObtenerLista(l)(0)

            For Each v As BE.Factura In ob.Lista_Facturas

                v.Distribuidor.ID = ob.Distribuidor.ID

                lp.Clear()
                lp.Add(v.PuntoVenta)
                v.PuntoVenta = bp.ObtenerPDVs(lp)(0)

                lv.Clear()
                lv.Add(v.Vendedor)
                v.Vendedor = bv.ObtenerVendedores(lv)(0)

                v.DVH = dvh.calcular(v)

                ' Guardo la cabecera de la factura
                d.Guardar(v)

                ' Guardo los detalles de la factura
                bdf.Guardar(v)
            Next
            ' Recalculo todos los digitos verificadores Verticales
            dvv.tabla = "Factura"
            dvv.calcular()

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try


    End Sub

    Public Function ObtenerFacturas(f As List(Of BE.Factura)) As List(Of BE.Factura)
        ObtenerFacturas = Nothing
    End Function


End Class