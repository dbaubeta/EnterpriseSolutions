Public Class Validador

    Dim dvh As New Digito_Horizontal

    Public Function validarDB() As List(Of BE.MensajeError)

        Dim db As New DAL.Bitacora
        Dim dca As New DAL.Categoria
        Dim dcl As New DAL.Cliente
        Dim ddi As New DAL.Distribuidor
        Dim del As New DAL.Elemento
        Dim dfa As New DAL.Factura
        Dim ddf As New DAL.Detalle_Factura
        Dim did As New DAL.Idioma
        Dim dle As New DAL.Leyenda
        Dim dju As New DAL.Justificacion
        Dim dpr As New DAL.Producto
        Dim dpu As New DAL.PuntodeVenta
        Dim dse As New DAL.Secuencia
        Dim dst As New DAL.Stock
        Dim dus As New DAL.Usuario
        Dim dve As New DAL.Vendedor


        Dim l As New List(Of BE.MensajeError)
        Dim str As String

        str = "Bitacora"
        Dim b1 As New BE.Bitacora
        Dim b2 As New BE.Bitacora
        b1.FechaHora = New Date(1900, 1, 1)
        b2.FechaHora = New Date(2099, 1, 1)
        Dim lb As New List(Of BE.Bitacora)
        lb.Add(b1)
        lb.Add(b2)
        For Each x In db.ObtenerEntradas(lb)
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Categoria"
        For Each x In dca.ObtenerLista()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Cliente"
        For Each x In dcl.ObtenerLista()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Distribuidor"
        For Each x In ddi.ObtenerLista()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Elemento"
        For Each x In del.ObtenerElementos()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Factura"
        For Each x In dfa.ObtenerFacturas()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Detalle_Factura"
        For Each x In ddf.ObtenerDetalles()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.FacturaID.ToString + ", " + x.Linea))
            End If
        Next

        str = "Idioma"
        For Each x In did.Obtener_Idiomas()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If

            Dim dvhIdioma As Long = 0
            For j As Integer = 0 To x.ID.ToString.Length - 1
                dvhIdioma += Asc(x.ID.ToString(j))
            Next

            Dim str2 As String = "Leyenda"
            For Each y In dle.ObtenerLeyendas(x)
                If (dvh.calcular(y) + dvhIdioma) <> y.DVH Then
                    l.Add(New BE.MensajeError("DVH_" + str2, "", x.ID.ToString + ", " + y.IDLeyenda))
                End If
            Next

        Next

        str = "Justificacion"
        For Each x In dju.Obtenerjustificaciones()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Producto"
        For Each x In dpr.ObtenerLista()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "PuntodeVenta"
        For Each x In dpu.ObtenerPDVs()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Secuencia"
        For Each x In dse.ObtenerSecuencias()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Stock"
        For Each x In dst.ObtenerStocks()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Usuario"
        For Each x In dus.ObtenerUsuarios()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next

        str = "Vendedor"
        For Each x In dve.ObtenerVendedores()
            If dvh.calcular(x) <> x.DVH Then
                l.Add(New BE.MensajeError("DVH_" + str, "", x.ID))
            End If
        Next




        Return l

    End Function




    Public Function RecalcularDB() As List(Of BE.MensajeError)

        Dim db As New DAL.Bitacora
        Dim dca As New DAL.Categoria
        Dim dcl As New DAL.Cliente
        Dim ddi As New DAL.Distribuidor
        Dim del As New DAL.Elemento
        Dim dfa As New DAL.Factura
        Dim ddf As New DAL.Detalle_Factura
        Dim did As New DAL.Idioma
        Dim dle As New DAL.Leyenda
        Dim dju As New DAL.Justificacion
        Dim dpr As New DAL.Producto
        Dim dpu As New DAL.PuntodeVenta
        Dim dse As New DAL.Secuencia
        Dim dst As New DAL.Stock
        Dim dus As New DAL.Usuario
        Dim dve As New DAL.Vendedor


        Dim l As New List(Of BE.MensajeError)
        Dim str As String

        str = "Bitacora"
        Dim b1 As New BE.Bitacora
        Dim b2 As New BE.Bitacora
        b1.FechaHora = New Date(1900, 1, 1)
        b2.FechaHora = New Date(2099, 1, 1)
        Dim lb As New List(Of BE.Bitacora)
        lb.Add(b1)
        lb.Add(b2)
        For Each x In db.ObtenerEntradas(lb)
            x.DVH = dvh.calcular(x)
            db.Guardar(x)
        Next

        str = "Categoria"
        For Each x In dca.ObtenerLista()
            x.DVH = dvh.calcular(x)
            dca.Guardar(x)
        Next

        str = "Cliente"
        For Each x In dcl.ObtenerLista()
            x.DVH = dvh.calcular(x)
            dcl.Guardar(x)
        Next

        str = "Distribuidor"
        For Each x In ddi.ObtenerLista()
            x.DVH = dvh.calcular(x)
            ddi.Guardar(x)
        Next

        str = "Elemento"
        For Each x In del.ObtenerElementos()
            x.DVH = dvh.calcular(x)
            del.Guardar(x)
        Next

        str = "Factura"
        For Each x In dfa.ObtenerFacturas()
            x.DVH = dvh.calcular(x)

            Dim det As New List(Of BE.Detalle_Factura)
            det = ddf.ObtenerDetalles(x)
            dfa.Guardar(x)
            For Each y In det
                y.DVH = dvh.calcular(y)
                ddf.Guardar(y)
            Next

        Next

        str = "Idioma"
        For Each x In did.Obtener_Idiomas()
            x.DVH = dvh.calcular(x)
            Dim str2 As String = "Leyenda"

            Dim dvhIdioma As Long = 0
            For j As Integer = 0 To x.ID.ToString.Length - 1
                dvhIdioma += Asc(x.ID.ToString(j))
            Next

            For Each y In x.Leyendas
                y.DVH = dvh.calcular(y) + dvhIdioma
            Next

            did.Guardar(x)
            dle.Guardar_Leyendas(x)

        Next

        str = "Justificacion"
        For Each x In dju.Obtenerjustificaciones()
            x.DVH = dvh.calcular(x)
            dju.Guardar(x)
        Next

        str = "Producto"
        For Each x In dpr.ObtenerLista()
            x.DVH = dvh.calcular(x)
            dpr.Guardar(x)
        Next

        str = "PuntodeVenta"
        Dim lpu As New List(Of BE.PuntodeVenta)
        lpu = dpu.ObtenerPDVs()
        For Each x In lpu
            x.DVH = dvh.calcular(x)
        Next
        dpu.Guardar(lpu)

        str = "Secuencia"
        For Each x In dse.ObtenerSecuencias()
            x.DVH = dvh.calcular(x)
            dse.Guardar(x)
        Next

        str = "Stock"
        For Each x In dst.ObtenerStocks()
            x.DVH = dvh.calcular(x)
            dst.Guardar(x)
        Next

        str = "Usuario"
        For Each x In dus.ObtenerUsuarios()
            x.DVH = dvh.calcular(x)
            dus.Guardar(x)
        Next

        str = "Vendedor"
        Dim lve As New List(Of BE.Vendedor)
        lve = dve.ObtenerVendedores()
        For Each x In lve
            x.DVH = dvh.calcular(x)
        Next
        dve.Guardar(lve)

        Return l

    End Function






End Class
