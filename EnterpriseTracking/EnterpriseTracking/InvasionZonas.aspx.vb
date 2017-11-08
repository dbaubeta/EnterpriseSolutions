Imports System.Drawing

Public Class InvasionZonas
    Inherits System.Web.UI.Page



    Dim p As New BLL.PuntodeVenta
    Dim markers As String = ""
    Dim mapcenterlat As Double = 0
    Dim mapcenterlong As Double = 0
    Dim ventacentrolat As Double = 0
    Dim ventacentrolong As Double = 0
    Dim ventaRadio As Double = 2000

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Dim b As New BLL.Distribuidor

        Try
            If Not IsPostBack Then

                Me.dlDistribuidores.DataValueField = "ID"
                Me.dlDistribuidores.DataTextField = "Nombre"
                ' Busco si el usuario logueado es un Distribuidor
                If IsNothing(Session("EsCliente")) Then
                    Me.dlDistribuidores.DataSource = b.ObtenerLista()
                    Me.dlDistribuidores.DataBind()
                    Me.dlDistribuidores.SelectedIndex = 0
                Else
                    Me.dlDistribuidores.DataSource = b.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = DirectCast(Session("EsCliente"), BE.Cliente).ID)
                    Me.dlDistribuidores.DataBind()
                    Me.dlDistribuidores.SelectedValue = DirectCast(Session("EsDistribuidor"), BE.Distribuidor).ID
                End If

            End If

            If Me.dlDistribuidores.Items.Count > 0 Then CargarGrilla()

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub CargarGrilla()

        Try

            Dim x As New BE.Distribuidor
            Dim bx As New BLL.Distribuidor
            Dim lx As New List(Of BE.ABM)

            If Not IsNothing(dlDistribuidores.SelectedValue) Then
                x.ID = dlDistribuidores.SelectedValue
                lx.Add(x)
                x = bx.ObtenerLista(lx)(0)

                ventacentrolat = x.AreaVentasCentroLat
                ventacentrolong = x.AreaVentasCentroLong
                ventaRadio = x.AreaVentasRadio

                Dim dt As DataTable = New DataTable
                dt.Columns.Add("ID")
                dt.Columns.Add("Nombre")
                dt.Columns.Add("Invade")

                Dim countmarkers As Integer = 0
                Dim minlat As Double = 99999999
                Dim minlong As Double = 999999999
                Dim maxlat As Double = -999999999
                Dim maxlong As Double = -999999999
                markers = ""
                For Each l As BE.PuntodeVenta In p.ObtenerPDVs().FindAll(Function(z) DirectCast(z, BE.PuntodeVenta).Distribuidor.ID = x.ID).OrderBy(Function(z) z.Nombre)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = l.ID
                    dr("Nombre") = l.Nombre

                    If (distancia(l.Latitud, l.Longitud, x.AreaVentasCentroLat, x.AreaVentasCentroLong, "K") * 1000 > x.AreaVentasRadio) And l.Latitud <> 0 And x.AreaVentasCentroLat <> 0 Then
                        dr("Invade") = 1
                    Else
                        dr("Invade") = 0
                    End If


                    dt.Rows.Add(dr)

                    countmarkers += 1
                    markers += "var marker" + countmarkers.ToString + " = new google.maps.Marker({position: new google.maps.LatLng(" + l.Latitud.ToString + ", " + l.Longitud.ToString + "),map: myMap,title: '" + l.Nombre + "'});"
                    If maxlat < l.Latitud Then maxlat = l.Latitud
                    If maxlong < l.Longitud Then maxlong = l.Longitud

                    If minlat > l.Latitud Then minlat = l.Latitud
                    If minlong > l.Longitud Then minlong = l.Longitud


                Next

                mapcenterlat = minlat + (maxlat - minlat) / 2
                mapcenterlong = minlong + (maxlong - minlong) / 2

                CreateMaps()

                grdPuntodeVentas.DataSource = Nothing
                grdPuntodeVentas.DataSource = dt
                grdPuntodeVentas.DataBind()

                If grdPuntodeVentas.Rows.Count > 0 Then
                    grdPuntodeVentas.UseAccessibleHeader = True
                    grdPuntodeVentas.HeaderRow.TableSection = TableRowSection.TableHeader
                End If

                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "initialize();", True)

            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Try
            For Each r As GridViewRow In Me.grdPuntoDeVentas.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdPuntoDeVentas, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdPuntoDeVentas.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdPuntoDeVentas.Rows
                If row.RowIndex = grdPuntoDeVentas.SelectedIndex Then
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                    row.ToolTip = String.Empty
                Else
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                    row.ToolTip = String.Empty
                End If
            Next

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "initialize();", True)

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub


    Private Sub MostrarMensajeModal(Msg As String, simple As Boolean, Optional traducir As Boolean = True)

        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla
        m.IDError = Msg
        If Not simple Then
            If traducir Then
                Try
                    noTranslateModalMessageSiNo.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Catch ex As Exception
                    noTranslateModalMessageSiNo.Text = Msg
                End Try
            Else
                noTranslateModalMessageSiNo.Text = Msg
            End If
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalSiNo();", True)
        Else
            If traducir Then
                Try
                    noTranslateModalMessage.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Catch ex As Exception
                    noTranslateModalMessage.Text = Msg
                End Try
            Else
                noTranslateModalMessage.Text = Msg
            End If
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalOk();", True)
        End If

    End Sub


    Protected Sub CreateMaps()

        Dim sb As New StringBuilder
        sb.Append("<script type='text/javascript'>")
        sb.Append("function initialize() {")
        sb.Append("var mapOptions = {")
        sb.Append("center: new google.maps.LatLng(" + mapcenterlat.tostring + ", " + mapcenterlong.tostring + "),")
        sb.Append("zoom: 13,")
        sb.Append("mapTypeId : google.maps.MapTypeId.ROADMAP")
        sb.Append("};")
        sb.Append("var myMap = new google.maps.Map(document.getElementById('mapArea'), mapOptions);")
        ' Agrego los markers
        sb.Append(markers)
        ' Agrego el circulo con la zona de venta
        sb.Append("var circleoptions = {")
        sb.Append("strokeColor: '#800000',")
        sb.Append("strokeOpacity: 1.0,")
        sb.Append("strokeWeight: 1,")
        sb.Append("fillColor:  '#C64D45',")
        sb.Append("fillOpacity: 0.5,")
        sb.Append("map: myMap,")
        sb.Append("center: new google.maps.LatLng(" + VentaCentrolat.ToString + ", " + VentaCentrolong.ToString + "),")
        sb.Append("radius: " + ventaRadio.ToString)
        sb.Append("};")
        sb.Append("circle = new google.maps.Circle(circleoptions);")
        sb.Append("}")
        sb.Append("</script>")

        Me.LitMaps.Text = sb.ToString

    End Sub

    Public Function distancia(ByVal lat1 As Double, ByVal lon1 As Double, ByVal lat2 As Double, ByVal lon2 As Double, ByVal unit As Char) As Double
        Dim theta As Double = lon1 - lon2
        Dim dist As Double = Math.Sin(deg2rad(lat1)) * Math.Sin(deg2rad(lat2)) + Math.Cos(deg2rad(lat1)) * Math.Cos(deg2rad(lat2)) * Math.Cos(deg2rad(theta))
        dist = Math.Acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515
        If unit = "K" Then
            dist = dist * 1.609344
        ElseIf unit = "N" Then
            dist = dist * 0.8684
        End If
        Return dist
    End Function

    Private Function deg2rad(ByVal deg As Double) As Double
        Return (deg * Math.PI / 180.0)
    End Function

    Private Function rad2deg(ByVal rad As Double) As Double
        Return rad / Math.PI * 180.0
    End Function



    Private Sub InvasionZonas_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        For i = 0 To grdPuntodeVentas.Rows.Count - 1

            If grdPuntodeVentas.DataKeys(i).Value = "1" Then

                grdPuntodeVentas.Rows(i).BackColor = ColorTranslator.FromHtml("#C64D45")

            End If

        Next

    End Sub
End Class