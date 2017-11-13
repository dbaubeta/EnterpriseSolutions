Public Class Stock

    Dim d As New DAL.Stock
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical

    Public Function CalcularStock(fecha As BE.Stock, prod As BE.Producto) As BE.Stock

        Dim bf As New BLL.Factura
        Dim bdf As New BLL.Detalle_Factura
        Dim bp As New BLL.Producto
        Dim bd As New BLL.Distribuidor
        Dim bs As New BLL.Stock
        Dim salida As New BE.Stock


        Dim ldi As New List(Of BE.ABM)
        ldi.Add(fecha.Distribuidor)
        fecha.Distribuidor = bd.ObtenerLista(ldi)(0)

        Dim ld As New List(Of BE.ABM)
        ld.Add(prod)
        prod = bp.ObtenerLista(ld).Find(Function(z) DirectCast(z, BE.Producto).Cliente.ID = fecha.Distribuidor.Cliente.ID)

        'Seteo los valores desde hasta, en base al mes y año
        Dim desde As New BE.Factura
        Dim hasta As New BE.Factura
        desde.Fecha = Convert.ToDateTime(New Date(1900, 1, 1))
        desde.Distribuidor = fecha.Distribuidor
        hasta.Fecha = fecha.Fecha
        If hasta.Fecha.Date >= Now.Date Then hasta.Fecha = Now.Date

        ' Obtengo los movimientos por factura
        'salida.Cantidad = 0
        'Dim ldf As List(Of BE.Detalle_Factura) = bdf.ObtenerDetalles(desde, hasta, prod)
        'For Each df As BE.Detalle_Factura In ldf
        '    salida.Cantidad += df.Cantidad * -1
        'Next

        ''Next

        'Dim desdes As New BE.Stock
        'Dim hastas As New BE.Stock
        'desdes.Distribuidor = desde.Distribuidor
        'desdes.Fecha = desde.Fecha
        'hastas.Fecha = hasta.Fecha

        '' Obtengo los movimientos por stock
        'Dim ls As List(Of BE.Stock) = bs.ObtenerStocks(desdes, hastas).FindAll(Function(z) DirectCast(z, BE.Stock).Distribuidor.ID = fecha.Distribuidor.ID).FindAll(Function(zz) DirectCast(zz, BE.Stock).Producto.ID = prod.ID)
        'For Each s As BE.Stock In ls
        '    If s.Tipo = "Entrada" Then
        '        salida.Cantidad += s.Cantidad
        '    Else
        '        salida.Cantidad += s.Cantidad * -1
        '    End If
        'Next
        salida.Cantidad = d.CalcularStock(desde, hasta, prod).Cantidad
        salida.Fecha = hasta.Fecha

        Return salida



    End Function

    Public Sub Guardar(ob As BE.Secuencia)


        ' Recalculo todos los digitos verificadores horizontales

        Dim bd As New BLL.Distribuidor
        Dim l As New List(Of BE.ABM)
        Dim bp As New BLL.Producto
        Dim lp As New List(Of BE.ABM)

        Try
            l.Add(ob.Distribuidor)
            ob.Distribuidor = bd.ObtenerLista(l)(0)

            For Each v As BE.Stock In ob.Lista_Stock
                ' Recalculo todos los digitos verificadores horizontales
                v.DVH = dvh.calcular(v)
                v.Distribuidor.ID = ob.Distribuidor.ID

                lp.Clear()
                lp.Add(v.Producto)
                v.Producto = bp.ObtenerLista(lp).Find(Function(x) DirectCast(x, BE.Producto).Cliente.ID = ob.Distribuidor.Cliente.ID)

                d.Guardar(v)
            Next

            dvv.tabla = "Stock"
            ' Recalculo todos los digitos verificadores Verticales
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

    Public Function ObtenerStocks(desde As BE.Stock, hasta As BE.Stock) As List(Of BE.Stock)

        Try

            Return d.ObtenerStocks(desde, hasta)


        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function ValorizarFIFO(l As List(Of BE.Stock)) As List(Of BE.Stock)
        ValorizarFIFO = Nothing
    End Function

    Public Function ValorizarLIFO(l As List(Of BE.Stock)) As List(Of BE.Stock)
        ValorizarLIFO = Nothing
    End Function

    Public Function ValorizarPP(l As List(Of BE.Stock)) As List(Of BE.Stock)
        ValorizarPP = Nothing
    End Function


End Class 