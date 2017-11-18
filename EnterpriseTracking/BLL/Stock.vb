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

        'Seteo los valores desde hasta, en base al mes y a�o
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

    Public Function ValorizarFIFO(hasta As BE.Stock, prod As BE.Producto) As BE.Stock
        Dim ListaCompleta As New List(Of BE.Stock)

        Dim bf As New DAL.Factura
        Dim desdef As New BE.Factura
        Dim hastaf As New BE.Factura
        Dim desdes As New BE.Stock
        Dim hastas As New BE.Stock
        Dim ddf As New DAL.Detalle_Factura

        desdef.Fecha = New Date(1900, 1, 1)
        desdef.Distribuidor = hasta.Distribuidor
        hastaf.Fecha = hasta.Fecha
        desdes.Fecha = desdef.Fecha
        desdes.Distribuidor = desdef.Distribuidor
        hastas.Fecha = hasta.Fecha

        'For Each f As BE.Factura In bf.ObtenerFacturas(desdef, hastaf)
        '    For Each df As BE.Detalle_Factura In f.Detalles_Factura
        '        Dim x As New BE.Stock
        '        x.Fecha = f.Fecha
        '        x.Cantidad = df.Cantidad
        '        x.Precio = df.Precio
        '        x.Tipo = "Salida"
        '        ListaCompleta.Add(x)
        '    Next
        'Next

        ListaCompleta.AddRange(ddf.ObtenerDetallescomoStock(desdef, hastaf, prod))
        ListaCompleta.AddRange(Me.ObtenerStocks(desdes, hastas).FindAll(Function(y) y.Producto.ID = prod.ID))

        Dim listaentradas As New List(Of BE.Stock)
        For Each st As BE.Stock In ListaCompleta.OrderBy(Function(x) x.Fecha).ThenBy(Function(z) z.Tipo)

            If st.Tipo = "Entrada" Then
                listaentradas.Add(st)
            Else
                Dim cantidadrestante As Long = st.Cantidad
                For Each se In listaentradas
                    If se.Cantidad > 0 Then
                        If se.Cantidad >= cantidadrestante Then
                            se.Cantidad = se.Cantidad - cantidadrestante
                            cantidadrestante = 0
                            Exit For
                        Else
                            cantidadrestante = cantidadrestante - se.Cantidad
                            se.Cantidad = 0
                        End If
                    End If
                Next
            End If
        Next


        ' Calculo lo que queda
        Dim total As New BE.Stock
        For Each st As BE.Stock In listaentradas
            total.Cantidad += st.Cantidad
            total.Precio += st.Precio * st.Cantidad
        Next

        Return total

    End Function

    Public Function ValorizarLIFO(hasta As BE.Stock, prod As BE.Producto) As BE.Stock
        Dim ListaCompleta As New List(Of BE.Stock)

        Dim bf As New DAL.Factura
        Dim desdef As New BE.Factura
        Dim hastaf As New BE.Factura
        Dim desdes As New BE.Stock
        Dim hastas As New BE.Stock
        Dim ddf As New DAL.Detalle_Factura

        desdef.Fecha = New Date(1900, 1, 1)
        desdef.Distribuidor = hasta.Distribuidor
        hastaf.Fecha = hasta.Fecha
        desdes.Fecha = desdef.Fecha
        desdes.Distribuidor = desdef.Distribuidor
        hastas.Fecha = hasta.Fecha

        'For Each f As BE.Factura In bf.ObtenerFacturas(desdef, hastaf)
        '    For Each df As BE.Detalle_Factura In f.Detalles_Factura
        '        Dim x As New BE.Stock
        '        x.Fecha = f.Fecha
        '        x.Cantidad = df.Cantidad
        '        x.Precio = df.Precio
        '        x.Tipo = "Salida"
        '        ListaCompleta.Add(x)
        '    Next
        'Next

        ListaCompleta.AddRange(ddf.ObtenerDetallescomoStock(desdef, hastaf, prod))
        ListaCompleta.AddRange(Me.ObtenerStocks(desdes, hastas).FindAll(Function(y) y.Producto.ID = prod.ID))

        Dim listaentradas As New List(Of BE.Stock)
        For Each st As BE.Stock In ListaCompleta.OrderBy(Function(x) x.Fecha).ThenBy(Function(z) z.Tipo)

            If st.Tipo = "Entrada" Then
                listaentradas.Insert(0, st)
            Else
                Dim cantidadrestante As Long = st.Cantidad
                For Each se In listaentradas
                    If se.Cantidad > 0 Then
                        If se.Cantidad >= cantidadrestante Then
                            se.Cantidad = se.Cantidad - cantidadrestante
                            cantidadrestante = 0
                            Exit For
                        Else
                            cantidadrestante = cantidadrestante - se.Cantidad
                            se.Cantidad = 0
                        End If
                    End If
                Next
            End If
        Next


        ' Calculo lo que queda
        Dim total As New BE.Stock
        For Each st As BE.Stock In listaentradas
            total.Cantidad += st.Cantidad
            total.Precio += st.Precio * st.Cantidad
        Next

        Return total

    End Function

    Public Function ValorizarPPP(hasta As BE.Stock, prod As BE.Producto) As BE.Stock
        Dim ListaCompleta As New List(Of BE.Stock)

        Dim bf As New DAL.Factura
        Dim desdef As New BE.Factura
        Dim hastaf As New BE.Factura
        Dim desdes As New BE.Stock
        Dim hastas As New BE.Stock
        Dim ddf As New DAL.Detalle_Factura

        desdef.Fecha = New Date(1900, 1, 1)
        desdef.Distribuidor = hasta.Distribuidor
        hastaf.Fecha = hasta.Fecha
        desdes.Fecha = desdef.Fecha
        desdes.Distribuidor = desdef.Distribuidor
        hastas.Fecha = hasta.Fecha

        ListaCompleta.AddRange(ddf.ObtenerDetallescomoStock(desdef, hastaf, prod))
        ListaCompleta.AddRange(Me.ObtenerStocks(desdes, hastas).FindAll(Function(y) y.Producto.ID = prod.ID))

        Dim listaentradas As New List(Of BE.Stock)
        Dim cantidad As Long = 0
        Dim PPP As Double = 0
        Dim montototal = 0

        For Each st As BE.Stock In ListaCompleta.OrderBy(Function(x) x.Fecha).ThenBy(Function(z) z.Tipo)

            If st.Tipo = "Entrada" Then
                listaentradas.Insert(0, st)
                cantidad += st.Cantidad
                montototal += st.Cantidad * st.Precio
                PPP = montototal / cantidad
            Else
                cantidad -= st.Cantidad
                montototal -= st.Cantidad * PPP

            End If
        Next

        ' Calculo lo que queda
        Dim total As New BE.Stock
        total.Cantidad = cantidad
        total.Precio = montototal

        Return total

    End Function



End Class 