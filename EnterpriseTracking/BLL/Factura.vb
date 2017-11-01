Public Class Factura

    Dim d As New DAL.Factura
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical

    Public Sub Guardar(ob As BE.Secuencia)
        Try
            ' Recalculo todos los digitos verificadores horizontales

            Dim bd As New BLL.Distribuidor
            Dim bdf As New BLL.Detalle_Factura

            Dim l As New List(Of BE.ABM)
            l.Add(ob.Distribuidor)
            ob.Distribuidor = bd.ObtenerLista(l)(0)

            For Each v As BE.Factura In ob.Lista_Facturas
                v.DVH = dvh.calcular(v)
                v.Distribuidor.ID = ob.Distribuidor.ID
                d.Guardar(v)
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