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

            For Each v As BE.Factura In ob.Lista_Facturas

                v.Distribuidor = ob.Distribuidor

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

    Public Function ObtenerFacturas(desde As BE.Factura, hasta As BE.Factura, Optional lazyload As Boolean = False) As List(Of BE.Factura)
        Try

            Return d.ObtenerFacturas(desde, hasta, LazyLoad)


        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function


    Public Function CalcularPorcentajeTransmisiones(desde As BE.Factura, hasta As BE.Factura) As Double

        Dim desdej As New BE.Justificacion
        Dim hastaj As New BE.Justificacion
        Dim bj As New BLL.Justificacion
        Dim p As New Persistencia
        p.EstablecerObjetoNegocio(New BLL.Distribuidor)

        desdej.Distribuidor = desde.Distribuidor
        desdej.Fecha = desde.Fecha
        hastaj.Fecha = hasta.Fecha

        Dim lf As List(Of BE.Factura) = ObtenerFacturas(desde, hasta, True).FindAll(Function(z) DirectCast(z, BE.Factura).Distribuidor.ID = desde.Distribuidor.ID)

        Dim lj As List(Of BE.Justificacion) = bj.ObtenerJustificaciones(desdej, hastaj).FindAll(Function(z) DirectCast(z, BE.Justificacion).Distribuidor.ID = desde.Distribuidor.ID)
        Dim total As Integer = 0
        Dim faltante As Integer = 0
        Dim dist As BE.Distribuidor = DirectCast(p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).ID = desde.Distribuidor.ID)(0), BE.Distribuidor)
        For idx = 1 To 31
            Dim dia As Integer = idx
            If idx <= hasta.Fecha.Day Then
                If dist.diasfactura.Substring(Int32.Parse(New DateTime(desde.Fecha.Year, desde.Fecha.Month, dia).DayOfWeek), 1) = "1" Then
                    total += 1
                    If IsNothing(lf.Find(Function(y) y.Fecha.Date = New DateTime(desde.Fecha.Year, desde.Fecha.Month, dia).Date)) Then
                        Dim jus As BE.Justificacion = lj.Find(Function(y) y.Fecha.Date = New DateTime(desde.Fecha.Year, desde.Fecha.Month, dia).Date)
                        If IsNothing(jus) Then
                            faltante += 1
                        End If
                    End If
                End If
            End If
        Next

        'Calculo porcentaje y meto en el div
        Dim porcentaje As Integer
        If total = 0 Then
            porcentaje = 0
        Else
            porcentaje = (total - faltante) * 100 / total
        End If

        Return porcentaje

    End Function



End Class