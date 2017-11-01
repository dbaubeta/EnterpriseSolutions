Public Class Detalle_Factura

    Dim d As New DAL.Detalle_Factura
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical


    Public Sub Guardar(ByVal ob As BE.Factura)

        Try
            ' Recalculo todos los digitos verificadores horizontales
            For Each v As BE.Detalle_Factura In ob.Detalles_Factura
                v.DVH = dvh.calcular(v)
                v.FacturaID = ob.ID
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

	Public Function ObtenerDetalles(ByVal f As List(Of BE.Factura)) As List( Of BE.Detalle_Factura)
		ObtenerDetalles = Nothing
	End Function


End Class