Imports System.Drawing
Imports System.Globalization

Public Class InvasionZonas
    Inherits System.Web.UI.Page

    Dim p As New BLL.PuntodeVenta
    Dim markers As String = ""
    Dim mapcenterlat As Double = 0
    Dim mapcenterlong As Double = 0
    Dim ventacentrolat As Double = 0
    Dim ventacentrolong As Double = 0
    Dim ventaRadio As Double = 2000
    Dim f As New BLL.Facade_Pantalla


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Dim b As New BLL.Cliente

        Try
            If Not IsPostBack Then


                Me.dlClientes.DataValueField = "ID"
                Me.dlClientes.DataTextField = "Nombre"
                ' Busco si el usuario logueado es un cliente
                If IsNothing(Session("EsCliente")) Then
                    Me.dlClientes.DataSource = b.ObtenerLista()
                    Me.dlClientes.DataBind()
                    Me.dlClientes.SelectedIndex = 0
                Else
                    Me.dlClientes.DataSource = b.ObtenerLista().FindAll(Function(z) z.ID = DirectCast(Session("EsCliente"), BE.Cliente).ID)
                    Me.dlClientes.DataBind()
                    Me.dlClientes.SelectedValue = DirectCast(Session("EsCliente"), BE.Cliente).ID
                    Me.dlClientes.Visible = False
                    Me.lblCliente.Visible = False

                End If


                Me.dlano.Items.Add(Now.Year.ToString)
                Me.dlano.Items.Add((Now.Year - 1).ToString)
                Me.dlano.Items.Add((Now.Year - 2).ToString)
                Me.dlano.Items.Add((Now.Year - 3).ToString)
                Me.dlano.Items.Add((Now.Year - 4).ToString)
                Me.dlano.SelectedValue = (Now.Year.ToString)
                CargarMeses()

                If dlClientes.Items.Count > 0 Then CargardlDistribuidores()

            End If

            If Me.dlDistribuidores.Items.Count > 0 Then CargarGrilla()

        Catch bex As BE.Excepcion
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Private Sub CargardlDistribuidores()
        Try
            Dim b As New BLL.Distribuidor
            Me.dlDistribuidores.Items.Clear()
            Me.dlDistribuidores.DataValueField = "ID"
            Me.dlDistribuidores.DataTextField = "Nombre"
            Me.dlDistribuidores.DataSource = b.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = dlClientes.SelectedValue)
            Me.dlDistribuidores.DataBind()
            If Me.dlDistribuidores.Items.Count > 0 Then Me.dlDistribuidores.SelectedIndex = 0
        Catch bex As BE.Excepcion
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try
    End Sub


    Private Sub CargarGrilla()

        Try

            Dim x As New BE.Distribuidor
            Dim bx As New BLL.Distribuidor
            Dim lx As New List(Of BE.ABM)
            Dim bf As New BLL.Factura
            Dim bj As New BLL.Justificacion


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
                dt.PrimaryKey = New DataColumn() {dt.Columns("ID")}

                Dim countmarkers As Integer = 0
                Dim minlat As Double = 99999999
                Dim minlong As Double = 999999999
                Dim maxlat As Double = -999999999
                Dim maxlong As Double = -999999999
                markers = ""

                'Seteo los valores desde hasta de facturas, en base al mes y año
                Dim desde As New BE.Factura
                Dim hasta As New BE.Factura
                desde.Fecha = Convert.ToDateTime(New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, 1))
                hasta.Fecha = Convert.ToDateTime(New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, Date.DaysInMonth(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1)))
                If hasta.Fecha.Date >= Now.Date Then hasta.Fecha = Now.Date

                desde.Distribuidor = x

                ' Obtengo las facuras de ese mes
                Dim lf As List(Of BE.Factura) = bf.ObtenerFacturas(desde, hasta).FindAll(Function(z) DirectCast(z, BE.Factura).Distribuidor.ID = desde.Distribuidor.ID)

                For Each fact As BE.Factura In lf

                    'Si ya no lo cargue en la lista de pdvs a mostrar, lo cargo
                    If IsNothing(dt.Rows.Find(fact.PuntoVenta.ID)) Then

                        Dim dr As DataRow = dt.NewRow
                        dr("ID") = fact.PuntoVenta.ID
                        dr("Nombre") = fact.PuntoVenta.Nombre
                        If fact.PuntoVenta.invade Then
                            dr("Invade") = 1
                        Else
                            dr("Invade") = 0
                        End If
                        dt.Rows.Add(dr)

                        countmarkers += 1
                        Dim us As CultureInfo = New CultureInfo("en-US")
                        markers += "var marker" + countmarkers.ToString + " = new google.maps.Marker({position: new google.maps.LatLng(" + fact.PuntoVenta.Latitud.ToString(us) + ", " + fact.PuntoVenta.Longitud.ToString(us) + "),map: myMap,title: '" + fact.PuntoVenta.Nombre + "'});"
                        If maxlat < fact.PuntoVenta.Latitud Then maxlat = fact.PuntoVenta.Latitud
                        If maxlong < fact.PuntoVenta.Longitud Then maxlong = fact.PuntoVenta.Longitud

                        If minlat > fact.PuntoVenta.Latitud Then minlat = fact.PuntoVenta.Latitud
                        If minlong > fact.PuntoVenta.Longitud Then minlong = fact.PuntoVenta.Longitud
                    End If

                Next

                Me.LitMaps.Text = ""
                If countmarkers = 0 Then

                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = ""
                    dr("Nombre") = ""
                    dr("Invade") = 0
                    dt.Rows.Add(dr)

                    'Else
                    'mapcenterlat = minlat + (maxlat - minlat) / 2
                    'mapcenterlong = minlong + (maxlong - minlong) / 2
                Else

                    mapcenterlat = x.AreaVentasCentroLat
                    mapcenterlong = x.AreaVentasCentroLong
                    CreateMaps()

                End If
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
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Try
            For Each r As GridViewRow In Me.grdPuntodeVentas.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdPuntodeVentas, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdPuntodeVentas.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdPuntodeVentas.Rows
                If row.RowIndex = grdPuntodeVentas.SelectedIndex Then
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                    row.ToolTip = String.Empty
                Else
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                    row.ToolTip = String.Empty
                End If
            Next

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "initialize();", True)

        Catch bex As BE.Excepcion
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
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
        Dim us As CultureInfo = New CultureInfo("en-US")

        sb.Append("<script type='text/javascript'>")
        sb.Append("function initialize() {")
        sb.Append("var mapOptions = {")
        sb.Append("zoom: 13,")
        If mapcenterlat <> 0 And mapcenterlong <> 0 Then
            sb.Append("mapTypeId : google.maps.MapTypeId.ROADMAP,")
            sb.Append("center: new google.maps.LatLng(" + mapcenterlat.ToString(us) + ", " + mapcenterlong.ToString(us) + ")")
            sb.Append("};")
            sb.Append("var myMap = new google.maps.Map(document.getElementById('mapArea'), mapOptions);")
        Else
            sb.Append("mapTypeId : google.maps.MapTypeId.ROADMAP")
            sb.Append("};")
            sb.Append("var myMap = new google.maps.Map(document.getElementById('mapArea'), mapOptions);")
            sb.Append("if (navigator.geolocation) {")
            sb.Append("navigator.geolocation.getCurrentPosition(function (position) {")
            sb.Append("initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);")
            sb.Append("myMap.setCenter(initialLocation);")
            sb.Append("});")
            sb.Append("}")
        End If
        ' Agrego los markers

        sb.Append(markers)
        ' Agrego el circulo con la zona de venta
        If ventacentrolat <> 0 And ventacentrolong <> 0 And ventaRadio <> 0 Then
            sb.Append("var circleoptions = {")
            sb.Append("strokeColor: '#800000',")
            sb.Append("strokeOpacity: 1.0,")
            sb.Append("strokeWeight: 1,")
            sb.Append("fillColor:  '#C64D45',")
            sb.Append("fillOpacity: 0.5,")
            sb.Append("map: myMap,")
            sb.Append("center: new google.maps.LatLng(" + ventacentrolat.ToString(us) + ", " + ventacentrolong.ToString(us) + "),")
            sb.Append("radius: " + ventaRadio.ToString(us))
            sb.Append("};")
            sb.Append("circle = new google.maps.Circle(circleoptions);")
        End If
        sb.Append("}")
        sb.Append("</script>")

        Me.LitMaps.Text = sb.ToString

    End Sub


    Private Sub dlClientes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlClientes.SelectedIndexChanged
        CargardlDistribuidores()
        Me.grdPuntodeVentas.DataSource = Nothing
        Me.grdPuntodeVentas.DataBind()
        Me.LitMaps.Text = ""
        CargarGrilla()
    End Sub

    Private Sub InvasionZonas_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        For i = 0 To grdPuntodeVentas.Rows.Count - 1
            If grdPuntodeVentas.DataKeys(i).Value = "1" Then
                grdPuntodeVentas.Rows(i).BackColor = ColorTranslator.FromHtml("#C64D45")
            End If
        Next
    End Sub


#Region "MesesAños"
    Private Sub cargarMeses()


        Dim maxmonth As Integer = 12
        If Me.dlano.SelectedItem.Text = Now.Year.ToString Then
            maxmonth = Now.Month
        End If
        Dim beforemonth As Integer = Me.dlmes.SelectedIndex

        Me.dlmes.Items.Clear()

        If maxmonth >= 1 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Enero", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 2 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Febrero", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 3 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Marzo", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 4 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Abril", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 5 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Mayo", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 6 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Junio", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 7 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Julio", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 8 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Agosto", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 9 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Septiembre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 10 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Octubre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 11 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Noviembre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
        If maxmonth >= 12 Then Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Diciembre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)

        If Not IsPostBack Then
            Me.dlmes.SelectedIndex = (Now.Month - 1)
        Else
            If (beforemonth + 1) > maxmonth Then
                Me.dlmes.SelectedIndex = maxmonth - 1
            Else
                Me.dlmes.SelectedIndex = beforemonth
            End If
        End If
    End Sub

    Private Sub dlano_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlano.SelectedIndexChanged
        cargarMeses()
    End Sub

#End Region
End Class