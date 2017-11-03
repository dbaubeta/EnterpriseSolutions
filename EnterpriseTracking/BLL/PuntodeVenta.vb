Imports System.Net

Public Class PuntodeVenta

    Dim d As New DAL.PuntodeVenta
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical


    Public Sub Guardar(ob As BE.Secuencia)

        ' Recalculo todos los digitos verificadores horizontales

        Dim bd As New BLL.Distribuidor
        Dim l As New List(Of BE.ABM)

        Dim bp As New BLL.Provincia
        Dim lp As New List(Of BE.Provincia)

        Dim bv As New BLL.Vendedor
        Dim lv As New List(Of BE.Vendedor)


        Try
            l.Add(ob.Distribuidor)
            ob.Distribuidor = bd.ObtenerLista(l)(0)

            For Each v As BE.PuntodeVenta In ob.Lista_PDV
                v.Distribuidor.ID = ob.Distribuidor.ID

                lp.Clear()
                lp.Add(v.Provincia)
                v.Provincia = bp.ObtenerProvincias(lp)(0)

                lv.Clear()
                lv.Add(v.Vendedor)
                v.Vendedor = bv.ObtenerVendedores(lv)(0)

                ' Geocodifico
                Dim direccion = v.Calle + " " + v.numero.ToString + "," + v.CodigoPostal + " " + v.Provincia.Nombre + ", Argentina"
                Dim requestUri = String.Format("https://maps.googleapis.com/maps/api/geocode/xml?address={0}&sensor=false&key=AIzaSyBclJiCQNdKGN5FV5Xr1elig-2Yk32vx8A", Uri.EscapeDataString(direccion))

                Dim request = WebRequest.Create(requestUri)
                Dim response = request.GetResponse()
                Dim xdoc = XDocument.Load(response.GetResponseStream())

                Dim result = xdoc.Element("GeocodeResponse").Element("result")
                If xdoc.Element("GeocodeResponse").Element("result").Value = "ZERO_RESULTS" Then
                    v.Latitud = 0
                    v.Longitud = 0
                Else
                    Dim locationElement = result.Element("geometry").Element("location")
                    v.Latitud = Double.Parse(locationElement.Element("lat").Value)
                    v.Longitud = Double.Parse(locationElement.Element("lng").Value)

                End If

                v.DVH = dvh.calcular(v)

            Next
            d.Guardar(ob.Lista_PDV)
            dvv.tabla = "PuntoDeVenta"
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

    Public Function ObtenerPDVs(Optional f As List(Of BE.PuntodeVenta) = Nothing) As List(Of BE.PuntodeVenta)
        Try
            Return d.ObtenerPDVs(f)

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