Imports System.IO
Imports System.Text
Imports System.Xml
Imports System.Xml.Schema
Imports System.Globalization

Public Class Secuencia


    Private _errors As New List(Of ValidationEventArgs)()
    Private listapuntoventa As New List(Of BE.PuntodeVenta)
    Private listaprovincias As New List(Of BE.Provincia)
    Private listaproductos As New List(Of BE.ABM)
    Private listavendedores As New List(Of BE.Vendedor)

    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical

    Dim d As New DAL.Secuencia


    Public Function Cargar(Archivo As String, xsd As String, seq As BE.Secuencia) As List(Of BE.MensajeError)

        Dim xmlDoc As New XmlDocument()
        Dim l As New List(Of BE.MensajeError)
        Dim l2 As New List(Of BE.MensajeError)
        Dim f As New Facade_Pantalla
        Dim m As New BE.MensajeError

        Try

            If Not XMLBienFormado(Archivo, xmlDoc) Then
                l.Add(New BE.MensajeError("CargaSeqListaBienFormado", "Fallo"))
            Else
                l2 = ValidarXMLconXSD(xmlDoc, xsd)
                If IsNothing(l2) Then
                    ' CARGAR el objeto secuencia
                    cargarSecuencia(xmlDoc, seq)
                Else
                    l.Add(New BE.MensajeError("CargaSeqListaBienFormado", "Correcto"))
                    l.Add(New BE.MensajeError("CargaSeqListaValido", "Fallo"))
                    l.Add(New BE.MensajeError(Nothing, " "))
                    l.Add(New BE.MensajeError("ListaErrores", Nothing))
                    l.AddRange(l2)
                End If
            End If

            Return l

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Sub Guardar(ob As BE.Secuencia)

        Dim bv As New BLL.Vendedor
        Dim bp As New BLL.PuntodeVenta
        Dim bf As New BLL.Factura
        Dim bs As New BLL.Stock

        Try

            bv.Guardar(ob)
            bp.Guardar(ob)
            bf.Guardar(ob)
            bs.Guardar(ob)

            ' Recalculo todos los digitos verificadores horizontales
            ob.DVH = dvh.calcular(ob)
            d.Guardar(ob)
            dvv.tabla = "Secuencia"
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

    Public Function Validar(s As BE.Secuencia) As List(Of BE.MensajeError)

        Dim p As New BLL.Persistencia
        Dim bp As New BLL.Provincia
        Dim bpu As New BLL.PuntodeVenta
        Dim bv As New BLL.Vendedor
        Dim errores As New List(Of BE.MensajeError)

        Try
            'Inicializo listas de validacion
            listapuntoventa = New List(Of BE.PuntodeVenta)
            listaprovincias = New List(Of BE.Provincia)
            listaproductos = New List(Of BE.ABM)
            listavendedores = New List(Of BE.Vendedor)

            'Obtengo el distribuidor
            p.EstablecerObjetoNegocio(New BLL.Distribuidor)
            Dim ll As New List(Of BE.ABM)
            Dim d As New BE.Distribuidor
            ll.Add(s.Distribuidor)
            d = p.ObtenerLista(ll)(0)

            If Not IsNothing(d) Then
                s.Distribuidor = d

                listaprovincias = bp.ObtenerProvincias()

                listavendedores.AddRange(bv.ObtenerVendedores().FindAll(Function(x) DirectCast(x, BE.Vendedor).Distribuidor.ID = s.Distribuidor.ID))
                listavendedores.AddRange(s.Lista_Vendedores)

                'Validar lista de punto de ventas
                For Each pu As BE.PuntodeVenta In s.Lista_PDV
                    If IsNothing(listavendedores.Find(Function(x) x.IDReal = pu.Vendedor.IDReal)) Then
                        errores.Add(New BE.MensajeError("PDVNoExisteVendedor", Nothing, pu.IDReal.ToString + vbTab + pu.Vendedor.IDReal.ToString))
                    End If
                    If IsNothing(listaprovincias.Find(Function(x) x.Nombre = pu.Provincia.Nombre)) Then
                        errores.Add(New BE.MensajeError("PDVNoExisteProvincia", Nothing, pu.IDReal.ToString + vbTab + pu.Provincia.Nombre))
                    End If

                Next

                listapuntoventa.AddRange(bpu.ObtenerPDVs().FindAll(Function(x) DirectCast(x, BE.PuntodeVenta).Distribuidor.ID = s.Distribuidor.ID))
                listapuntoventa.AddRange(s.Lista_PDV)

                p.EstablecerObjetoNegocio(New BLL.Producto)
                listaproductos = p.ObtenerLista().FindAll(Function(x) DirectCast(x, BE.Producto).Cliente.ID = s.Distribuidor.Cliente.ID)

                'Validar Facturas
                For Each fa As BE.Factura In s.Lista_Facturas
                    If IsNothing(listavendedores.Find(Function(x) x.IDReal = fa.Vendedor.IDReal)) Then
                        errores.Add(New BE.MensajeError("FacturaNoExisteVendedor", Nothing, fa.Nro_Factura_Real.ToString + vbTab + fa.Vendedor.IDReal.ToString))
                    End If
                    If IsNothing(listapuntoventa.Find(Function(x) x.IDReal = fa.PuntoVenta.IDReal)) Then
                        errores.Add(New BE.MensajeError("FacturaNoExistePDV", Nothing, fa.Nro_Factura_Real.ToString + vbTab + fa.PuntoVenta.IDReal.ToString))
                    End If


                    ' Valido detalles de la factura
                    For Each df As BE.Detalle_Factura In fa.Detalles_Factura

                        'producto
                        If IsNothing(listaproductos.Find(Function(x) DirectCast(x, BE.Producto).IDReal = df.Producto.IDReal)) Then
                            errores.Add(New BE.MensajeError("DetalleFacturaNoExisteProducto", Nothing, df.Linea.ToString + vbTab + fa.Nro_Factura_Real.ToString + vbTab + df.Producto.IDReal.ToString))
                        End If


                    Next

                Next

                'Validar Stock
                For Each st As BE.Stock In s.Lista_Stock
                    'producto
                    If IsNothing(listaproductos.Find(Function(x) DirectCast(x, BE.Producto).IDReal = st.Producto.IDReal)) Then
                        errores.Add(New BE.MensajeError("StockNoExisteProducto", Nothing, st.Fecha.ToString + vbTab + st.Producto.IDReal.ToString))
                    End If
                Next


            Else
                'Error no existe el distribuidor
            End If

            Return errores

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function


#Region "CargaSecuencia"

    Private Sub cargarSecuencia(xmldoc As XmlDocument, ByRef s As BE.Secuencia)

        Dim root As XmlElement = xmldoc.DocumentElement
        Dim distribuidor As String = root("distribuidor").InnerText

        Dim d As New BE.Distribuidor
        d.IDReal = distribuidor
        s.Distribuidor = d
        s.Nro_Secuencia_Real = Long.Parse(root("IDReal").InnerText)
        ' Obtengo el distribuidor
        '            Dim bd As New BLL.Distribuidor
        '            Dim l As New List(Of BE.ABM)
        '            l.Add(d)
        '            d = bd.ObtenerLista(l)(0)
        cargarVendedores(xmldoc, s)
        cargarPuntodeVenta(xmldoc, s)
        cargarFacturas(xmldoc, s)
        cargarStock(xmldoc, s)


    End Sub

    Private Sub cargarVendedores(xmldoc As XmlDocument, ByRef s As BE.Secuencia)

        Dim root As XmlElement = xmldoc.DocumentElement
        Dim vendedores As XmlElement = root("vendedores")
        Dim nodelist As XmlNodeList = vendedores.GetElementsByTagName("vendedor")

        For Each node As XmlElement In nodelist
            Dim x As New BE.Vendedor

            x.Distribuidor = s.Distribuidor
            x.IDReal = node("id").InnerText
            x.Nombre = node("nombre").InnerText
            x.borrado = IIf(node("borrado").InnerText = "1", True, False)

            s.Lista_Vendedores.Add(x)

        Next

    End Sub

    Private Sub cargarPuntodeVenta(xmldoc As XmlDocument, ByRef s As BE.Secuencia)

        Dim root As XmlElement = xmldoc.DocumentElement
        Dim puntosventa As XmlElement = root("puntosventa")
        Dim nodelist As XmlNodeList = puntosventa.GetElementsByTagName("puntoventa")

        For Each node As XmlElement In nodelist
            Dim x As New BE.PuntodeVenta

            x.Distribuidor = s.Distribuidor
            x.IDReal = node("id").InnerText
            x.Nombre = node("nombre").InnerText
            x.Calle = node("calle").InnerText
            x.numero = Int32.Parse(node("numero").InnerText)
            x.Depto = node("depto").InnerText
            x.CodigoPostal = node("cp").InnerText
            Dim p As New BE.Provincia
            p.Nombre = node("provincia").InnerText
            x.Provincia = p
            Dim v As New BE.Vendedor
            v.IDReal = node("vendedor").InnerText
            x.Vendedor = v
            x.CUIT = node("cuit").InnerText
            x.borrado = IIf(node("borrado").InnerText = "1", True, False)

            s.Lista_PDV.Add(x)

        Next

    End Sub


    Private Sub cargarFacturas(xmldoc As XmlDocument, ByRef s As BE.Secuencia)

        Dim root As XmlElement = xmldoc.DocumentElement
        Dim facturas As XmlElement = root("facturas")
        Dim nodelist As XmlNodeList = facturas.GetElementsByTagName("factura")

        For Each node As XmlElement In nodelist
            Dim x As New BE.Factura

            x.Distribuidor = s.Distribuidor
            x.Nro_Factura_Real = node("nrofactura").InnerText
            x.Fecha = Date.ParseExact(node("fecha").InnerText, "yyyy-MM-dd", CultureInfo.InvariantCulture)
            Dim p As New BE.PuntodeVenta
            p.IDReal = node("puntoventa").InnerText
            x.PuntoVenta = p
            Dim v As New BE.Vendedor
            v.IDReal = node("vendedor").InnerText
            x.Vendedor = v
            x.borrado = IIf(node("borrado").InnerText = "1", True, False)

            ' Cargo el detalle de la factura
            Dim detalles As XmlElement = node("detallesfactura")
            Dim detalleslist As XmlNodeList = detalles.GetElementsByTagName("detallefactura")
            For Each nodedetalle As XmlElement In detalleslist

                Dim xd As New BE.Detalle_Factura

                xd.Linea = Int32.Parse(nodedetalle("linea").InnerText)
                Dim pr As New BE.Producto
                pr.IDReal = nodedetalle("producto").InnerText
                xd.Producto = pr
                xd.Cantidad = Int64.Parse(nodedetalle("cantidad").InnerText)
                xd.Precio = Double.Parse(nodedetalle("cantidad").InnerText)
                x.Detalles_Factura.Add(xd)

            Next


            s.Lista_Facturas.Add(x)

        Next

    End Sub

    Private Sub cargarStock(xmldoc As XmlDocument, ByRef s As BE.Secuencia)

        Dim root As XmlElement = xmldoc.DocumentElement
        Dim stocks As XmlElement = root("stocks")
        Dim nodelist As XmlNodeList = stocks.GetElementsByTagName("stock")

        For Each node As XmlElement In nodelist
            Dim x As New BE.Stock

            x.Distribuidor = s.Distribuidor
            x.Fecha = Date.ParseExact(node("fecha").InnerText, "yyyy-MM-dd", CultureInfo.InvariantCulture)
            Dim pr As New BE.Producto
            pr.IDReal = node("producto").InnerText
            x.Producto = pr
            x.Cantidad = Int64.Parse(node("cantidad").InnerText)
            x.Precio = Double.Parse(node("precio").InnerText)
            x.Tipo = node("tipo").InnerText
            s.Lista_Stock.Add(x)

        Next

    End Sub

#End Region

#Region "XMLValidation"

    Private Function XMLBienFormado(value As String, ByRef xmldoc As XmlDocument) As Boolean
        Try

            If String.IsNullOrEmpty(value) = False Then
                Dim _byteOrderMarkUtf8 As String = Encoding.UTF8.GetString(Encoding.UTF8.GetPreamble())
                xmldoc.Load(value)
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As System.Xml.XmlException
            Return False
        End Try
    End Function

    Public Function ValidarXMLconXSD(doc As XmlDocument, xsdFilePath As String) As List(Of BE.MensajeError)

        Dim l As List(Of BE.MensajeError)

        doc.Schemas.Add(Nothing, xsdFilePath)
        'Dim errorBuilder As New XmlValidationErrorBuilder()
        doc.Validate(New ValidationEventHandler(AddressOf Me.ValidationEventHandler))
        l = Me.GetErrors()
        Return l

    End Function

    '    Private Class XmlValidationErrorBuilder

    Public Sub ValidationEventHandler(ByVal sender As Object, ByVal args As ValidationEventArgs)
        If args.Severity = XmlSeverityType.Error Then
            _errors.Add(args)
        End If
    End Sub

    Public Function GetErrors() As List(Of BE.MensajeError)
        Dim l As New List(Of BE.MensajeError)
        If _errors.Count <> 0 Then
            For Each i As ValidationEventArgs In _errors
                Dim it As New BE.MensajeError
                it.Mensaje = i.Message
                l.Add(it)
            Next
            Return l
        Else
            Return Nothing
        End If
    End Function
    '    End Class
#End Region



End Class ' BLL.Secuencia