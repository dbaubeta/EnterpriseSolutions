Imports System.IO
Imports System.Text
Imports System.Xml
Imports System.Xml.Schema

Public Class Secuencia

    Private _errors As New List(Of ValidationEventArgs)()



    Public Function Cargar(Archivo As String, xsd As String, seq As BE.Secuencia) As List(Of BE.MensajeError)

        Dim xmlDoc As New XmlDocument()
        Dim l As New List(Of BE.MensajeError)
        Dim f As New Facade_Pantalla

        Try

            If Not XMLBienFormado(Archivo, xmlDoc) Then
                Dim m As New BE.MensajeError
                m.IDError = "XMLNoEstaBienFormado"
                l.Add(m)
            Else
                l = ValidarXMLconXSD(xmlDoc, xsd)
                If IsNothing(l) Then
                    ' CARGAR el objeto secuencia
                    cargarVendedores(xmlDoc, seq)
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

    Public Sub Guardar(ByVal ob As BE.Secuencia)

    End Sub

    Public Function ObtenerSecuencias(ByVal f As List(Of BE.Secuencia)) As List(Of BE.Secuencia)
        ObtenerSecuencias = Nothing
    End Function

    Public Function Validar(ByVal s As BE.Secuencia) As List(Of BE.MensajeError)
        Validar = Nothing
    End Function


#Region "CargaSecuencia"

    Private Sub cargarVendedores(xmldoc As XmlDocument, ByRef s As BE.Secuencia)

        Dim root As XmlElement = xmldoc.DocumentElement
        Dim distribuidor As String = root("distribuidor").InnerText
        Dim vendedores As XmlElement = root("vendedores")
        Dim nodelist As XmlNodeList = vendedores.GetElementsByTagName("vendedor")

        For Each node As XmlElement In nodelist
            Dim x As New BE.Vendedor

            ' Obtengo el distribuidor
            Dim bd As New BLL.Distribuidor
            Dim d As New BE.Distribuidor
            d.IDReal = distribuidor
            Dim l As New List(Of BE.ABM)
            l.Add(d)
            d = bd.ObtenerLista(l)(0)

            x.Distribuidor = d
            x.IDReal = node("id").InnerText
            x.Nombre = node("nombre").InnerText
            x.borrado = IIf(node("borrado").InnerText = "1", True, False)

            s.Lista_Vendedores.Add(x)

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