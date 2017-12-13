Imports System.Drawing
Imports System.Globalization

Public Class VtasxCatProd
    Inherits System.Web.UI.Page

    Dim p As New BLL.Persistencia
    Dim br As New BLL.Reportes
    Dim strClase As String = "Producto"
    Public doughnut As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Dim b As New BLL.Cliente
        p.EstablecerObjetoNegocio(New BLL.Producto)

        Try
            If Not IsPostBack Then

                Me.dlClientes.DataValueField = "ID"
                Me.dlClientes.DataTextField = "Nombre"
                ' Busco si el usuario logueado es un cliente
                If Not IsNothing(Session("EsCliente")) Then
                    Me.dlClientes.DataSource = b.ObtenerLista().FindAll(Function(z) z.ID = DirectCast(Session("EsCliente"), BE.Cliente).ID)
                    Me.dlClientes.DataBind()
                    Me.dlClientes.SelectedValue = DirectCast(Session("EsCliente"), BE.Cliente).ID
                    Me.dlClientes.Visible = False
                    Me.lblCliente.Visible = False
                ElseIf Not IsNothing(Session("EsDistribuidor")) Then
                    Me.dlClientes.DataSource = b.ObtenerLista().FindAll(Function(z) z.ID = DirectCast(Session("EsDistribuidor"), BE.Distribuidor).Cliente.ID)
                    Me.dlClientes.DataBind()
                    Me.dlClientes.SelectedValue = DirectCast(Session("EsDistribuidor"), BE.Distribuidor).Cliente.ID
                    Me.dlClientes.Visible = False
                    Me.lblCliente.Visible = False
                Else
                    Me.dlClientes.DataSource = b.ObtenerLista()
                    Me.dlClientes.DataBind()
                    Me.dlClientes.SelectedIndex = 0

                End If

                Me.CalendarExtender1.EndDate = Now.Date
                Me.CalendarExtender1.SelectedDate = New Date(Now.Date.Year, Now.Date.Month, 1)
                Me.CalendarExtender2.EndDate = Now.Date
                Me.CalendarExtender2.SelectedDate = Now.Date

                Session("Desde") = Me.CalendarExtender1.SelectedDate
                Session("Hasta") = Me.CalendarExtender2.SelectedDate

                Me.txtFiltro.Visible = False
                Me.lblFiltro.Visible = False

                If dlClientes.Items.Count > 0 Then CargardlDistribuidores()



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


    Private Sub CargarGrilla()

        Try

            Dim x As New BE.Cliente
            Dim bx As New BLL.Cliente
            Dim lx As New List(Of BE.ABM)

            If Not IsNothing(dlClientes.SelectedValue) And Not IsNothing(dlDistribuidores.SelectedValue) Then
                x.ID = dlClientes.SelectedValue
                lx.Add(x)
                x = bx.ObtenerLista(lx)(0)

                Dim dt As DataTable = New DataTable
                dt.Columns.Add("ID")
                dt.Columns.Add("IDCategoria")
                dt.Columns.Add("Nombre")
                dt.Columns.Add("Categoria")
                dt.Columns.Add("Unidades")
                dt.Columns.Add("Monto")

                Dim desde As New BE.Factura
                Dim hasta As New BE.Factura
                desde.Distribuidor.ID = dlDistribuidores.SelectedValue
                hasta.Distribuidor.ID = dlDistribuidores.SelectedValue
                desde.Fecha = DirectCast(Session("Desde"), Date)
                hasta.Fecha = DirectCast(Session("Hasta"), Date)

                For Each l As BE.Rep_Vtas_prod_cat In br.Obtener_Ventas_Prod_Cat(desde, hasta)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = l.Producto.ID
                    dr("Nombre") = l.Producto.Nombre
                    dr("IDCategoria") = l.Categoria.ID
                    dr("Categoria") = l.Categoria.Nombre
                    dr("Unidades") = l.Cantidad
                    dr("monto") = l.monto
                    dt.Rows.Add(dr)
                Next

                grdVentas.DataSource = Nothing
                grdVentas.DataSource = dt
                grdVentas.DataBind()

                If grdVentas.Rows.Count > 0 Then
                    grdVentas.UseAccessibleHeader = True
                    grdVentas.HeaderRow.TableSection = TableRowSection.TableHeader
                    DibujarTorta()
                End If

                Me.txtFiltro.Visible = True
                Me.lblFiltro.Visible = True

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

    Private Sub CargardlDistribuidores()
        Try
            Dim b As New BLL.Distribuidor
            Me.dlDistribuidores.Items.Clear()
            Me.dlDistribuidores.DataValueField = "ID"
            Me.dlDistribuidores.DataTextField = "Nombre"
            If Not IsNothing(Session("EsDistribuidor")) Then
                Me.dlDistribuidores.DataSource = b.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).ID = DirectCast(Session("EsDistribuidor"), BE.Distribuidor).ID)
            Else
                Me.dlDistribuidores.DataSource = b.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = dlClientes.SelectedValue)
            End If
            Me.dlDistribuidores.DataBind()
            If Me.dlDistribuidores.Items.Count > 0 Then Me.dlDistribuidores.SelectedIndex = 0

            If Not IsNothing(Session("EsDistribuidor")) Then
                Me.dlDistribuidores.Visible = False
                Me.lblDistribuidor.Visible = False
            Else
                Me.dlDistribuidores.Visible = True
                Me.lblDistribuidor.Visible = True
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
            For Each r As GridViewRow In Me.grdVentas.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdVentas, "Select$" + r.RowIndex.ToString, True)
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "clickenfila();", True)
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

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdVentas.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdVentas.Rows
                If row.RowIndex = grdVentas.SelectedIndex Then
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                    row.ToolTip = String.Empty
                    DibujarGrafica()
                Else
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                    row.ToolTip = String.Empty
                End If
            Next
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


    Protected Sub DibujarGrafica()

        Dim sb As New StringBuilder

        Dim datastr As String = "                data: ["
        Dim labelsstr As String = "                labels: ["""
        Dim fechainicio As Date = DirectCast(Session("Hasta"), Date)
        Try
            For i = 11 To 0 Step -1
                Dim desde As New BE.Factura
                Dim hasta As New BE.Factura
                desde.Distribuidor.ID = dlDistribuidores.SelectedValue
                hasta.Distribuidor.ID = dlDistribuidores.SelectedValue
                desde.Fecha = ObtenerPrimerdia(fechainicio.AddMonths(i * -1))
                hasta.Fecha = ObtenerUltimodia(fechainicio.AddMonths(i * -1))
                If hasta.Fecha > Now.Date Then hasta.Fecha = Now.Date
                Dim monto As Double = 0
                Dim cantidad As Long = 0
                For Each l As BE.Rep_Vtas_prod_cat In br.Obtener_Ventas_Prod_Cat(desde, hasta).FindAll(Function(z) z.Producto.ID = Int32.Parse(grdVentas.DataKeys(grdVentas.SelectedRow.RowIndex).Value))
                    cantidad += l.Cantidad
                    monto += l.monto
                Next
                datastr += monto.ToString
                labelsstr += obtenertextomes(desde.Fecha.Month) + " " + desde.Fecha.Year.ToString
                If i = 0 Then datastr += "]," Else datastr += ","
                If i = 0 Then labelsstr += """]," Else labelsstr += ""","""
            Next

            sb.Clear()

            If Not IsNothing(grdVentas.SelectedIndex) Then

                sb.AppendLine("<script>")
                sb.AppendLine("function dibujarhistorial() {")
                sb.AppendLine("    var ctx = document.getElementById('historial');")
                sb.AppendLine("    var chart = new Chart(ctx, {")
                sb.AppendLine("        // Tipo de Chart")
                sb.AppendLine("        type: 'line',")
                sb.AppendLine("        // Los datos")
                sb.AppendLine("        data: {")
                sb.AppendLine(labelsstr)
                sb.AppendLine("            datasets: [{")
                sb.AppendLine("                label: """ + Me.grdVentas.Rows(grdVentas.SelectedIndex).Cells(1).Text + """,")
                sb.AppendLine("                backgroundColor: 'rgba(63, 142, 191, 0.75)',")
                sb.AppendLine("                borderColor: 'rgba(0, 66, 107, 1)',")
                sb.AppendLine(datastr)
                sb.AppendLine("                tension: 0.1,")
                sb.AppendLine("            }]")
                sb.AppendLine("        },")
                sb.AppendLine("        // Opciones para el chart")
                sb.AppendLine("        options: {")
                sb.AppendLine("            responsive: true,")
                sb.AppendLine("            maintainAspectRatio: false,")
                sb.AppendLine("            animation: {")
                sb.AppendLine("                duration: 1000, // general animation time")
                sb.AppendLine("            }")
                sb.AppendLine("        }")
                sb.AppendLine("    });")
                sb.AppendLine("}")
                sb.AppendLine("</script>")


                LitChart.Text = sb.ToString

                'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "dibujarcharts();", True)

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



    Protected Sub DibujarTorta()

        Dim sb As New StringBuilder
        Dim datastr As String = "                data: ["
        Dim labelsstr As String = "                labels: ["""
        Dim desde As New BE.Factura
        Dim hasta As New BE.Factura
        Dim monto As Double = 0
        Dim cantidad As Long = 0
        Dim ultimacategoria As Long = 0
        Dim ultimacategorianombre As String = ""
        Dim topCategorias As Integer = 5 ' Seteo cuantas categorias maximas quiero ver en la torta
        Dim cuentacategorias As Integer = 1
        Try
            desde.Distribuidor.ID = dlDistribuidores.SelectedValue
            hasta.Distribuidor.ID = dlDistribuidores.SelectedValue
            desde.Fecha = DirectCast(Session("Desde"), Date)
            hasta.Fecha = DirectCast(Session("Hasta"), Date)
            For Each l As BE.Rep_Vtas_prod_cat In br.Obtener_Ventas_Prod_Cat(desde, hasta)
                ' Hago corte de control por categoria
                If ultimacategoria = 0 Then
                    ultimacategoria = l.Categoria.ID
                    ultimacategorianombre = l.Categoria.Nombre
                End If
                If ultimacategoria <> l.Categoria.ID Then
                    If cuentacategorias <= topCategorias Then 'No agrego mas si esta por encima del top x
                        datastr += monto.ToString + ","
                        labelsstr += ultimacategorianombre + ""","""
                    End If
                    ultimacategoria = l.Categoria.ID
                    ultimacategorianombre = l.Categoria.Nombre
                    monto = 0
                    cantidad = 0
                    cuentacategorias += 1
                End If
                cantidad += l.Cantidad
                monto += l.monto
            Next
            If cuentacategorias <= topCategorias Then 'No agrego mas si esta por encima del top x
                datastr += IIf(ultimacategoria = 0, "", monto.ToString) + "],"
                labelsstr += IIf(ultimacategoria = 0, "", ultimacategorianombre) + """],"
            Else
                datastr += "],"
                labelsstr += """],"

            End If

            sb.Clear()

            sb.AppendLine("<script>")
            sb.AppendLine("function dibujartorta() {")
            sb.AppendLine("    var ctx = document.getElementById('torta');")
            sb.AppendLine("    var chart = new Chart(ctx, {")
            sb.AppendLine("        // Tipo de Chart")
            sb.AppendLine("        type: 'doughnut',")
            sb.AppendLine("        // Los datos")
            sb.AppendLine("        data: {")
            sb.AppendLine(labelsstr)
            sb.AppendLine("            datasets: [{")
            sb.AppendLine("                label: ""Ventas"",")
            sb.AppendLine(datastr)
            sb.AppendLine("                backgroundColor: [""#ff6384"", ""#36a2eb"", ""#cc65fe"", ""#ffce56"", ""#228B22""],")
            sb.AppendLine("            }]")
            sb.AppendLine("        },")
            sb.AppendLine("        // Opciones para el chart")
            sb.AppendLine("        options: {")
            sb.AppendLine("            responsive: true,")
            sb.AppendLine("            maintainAspectRatio: false,")
            sb.AppendLine("            animation: {")
            sb.AppendLine("                duration: 1000, // general animation time")
            sb.AppendLine("            }")
            sb.AppendLine("        }")
            sb.AppendLine("    });")
            sb.AppendLine("}")
            sb.AppendLine("</script>")


            LitTorta.Text = sb.ToString

            doughnut = sb.ToString
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "dibujartorta();", True)

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


    Private Sub VtasxCatProd_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Try
            Me.CalendarExtender1.Format = Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern
            Me.CalendarExtender2.Format = Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern
            CalendarExtender1.SelectedDate = DirectCast(Session("Desde"), Date)
            CalendarExtender2.SelectedDate = DirectCast(Session("Hasta"), Date)

            Me.txtDesde.Text = DirectCast(Session("Desde"), Date).ToString(Me.CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture))
            Me.txthasta.Text = DirectCast(Session("Hasta"), Date).ToString(Me.CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture))

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

    Private Function ObtenerPrimerdia(fecha As DateTime) As DateTime
        Return New DateTime(fecha.Year, fecha.Month, 1)

    End Function

    Private Function ObtenerUltimodia(fecha As DateTime) As DateTime
        Return New DateTime(fecha.Year, fecha.Month, DateTime.DaysInMonth(fecha.Year, fecha.Month))

    End Function


    Private Function obtenertextomes(mes As Integer) As String
        Try
            Dim strbusqueda As String = ""
            Select Case mes
                Case 1
                    strbusqueda = "enero"
                Case 2
                    strbusqueda = "febrero"
                Case 3
                    strbusqueda = "marzo"
                Case 4
                    strbusqueda = "abril"
                Case 5
                    strbusqueda = "mayo"
                Case 6
                    strbusqueda = "junio"
                Case 7
                    strbusqueda = "julio"
                Case 8
                    strbusqueda = "agosto"
                Case 9
                    strbusqueda = "septiembre"
                Case 10
                    strbusqueda = "octubre"
                Case 11
                    strbusqueda = "noviembre"
                Case 12
                    strbusqueda = "diciembre"
            End Select

            Dim f As New BLL.Facade_Pantalla
            Return f.ObtenerLeyenda(New BE.MensajeError(strbusqueda + "corto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda


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
        Return Nothing
    End Function


    Private Sub btnProcesar_Click(sender As Object, e As EventArgs) Handles btnProcesar.Click

        Dim desde As Date
        Dim hasta As Date
        Dim hayerror As Boolean = False

        If DateTime.TryParseExact(Me.txtDesde.Text, CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture), DateTimeStyles.None, desde) Then
            Session("Desde") = desde
        Else
            MostrarMensajeModal("FechaDesdeInvalida", True, True)
            hayerror = True
        End If
        If DateTime.TryParseExact(Me.txthasta.Text, CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture), DateTimeStyles.None, hasta) Then
            Session("Hasta") = hasta
        Else
            MostrarMensajeModal("FechaHastaInvalida", True, True)
            hayerror = True
        End If


        If Not hayerror Then

            If Me.dlClientes.Items.Count > 0 And Me.dlDistribuidores.Items.Count > 0 Then
                If desde > hasta Then
                    MostrarMensajeModal("FechaDesdeMayorFechaHasta", True)
                Else
                    CargarGrilla()
                    DibujarTorta()
                End If
            End If

        End If

    End Sub

    Private Sub dlClientes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlClientes.SelectedIndexChanged

        CargardlDistribuidores()

    End Sub
End Class