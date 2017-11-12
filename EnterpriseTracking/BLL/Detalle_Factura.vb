Public Class Detalle_Factura

    Dim d As New DAL.Detalle_Factura
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical


    Public Sub Guardar(ByVal ob As BE.Factura)

        Dim bp As New BLL.Producto
        Dim lp As New List(Of BE.ABM)

        Try
            ' Recalculo todos los digitos verificadores horizontales
            For Each v As BE.Detalle_Factura In ob.Detalles_Factura
                v.FacturaID = ob.ID

                lp.Clear()
                lp.Add(v.Producto)
                v.Producto = bp.ObtenerLista(lp).Find(Function(x) DirectCast(x, BE.Producto).Cliente.ID = ob.Distribuidor.Cliente.ID)

                v.DVH = dvh.calcular(v)
                d.Guardar(v)
            Next
            ' Recalculo todos los digitos verificadores Verticales
            dvv.tabla = "FacturaDetalle"
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

    Public Function ObtenerDetalles(f As BE.Factura) As List(Of BE.Detalle_Factura)

        Try

            Return d.ObtenerDetalles(f)

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