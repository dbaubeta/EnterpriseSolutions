Imports System.Drawing

Public Class VtasxCatProd
    Inherits System.Web.UI.Page

    Dim p As New BLL.Persistencia
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

                Me.CalendarExtender1.EndDate = Now.Date
                Me.CalendarExtender1.SelectedDate = Now.Date

            End If

            If Me.dlClientes.Items.Count > 0 Then CargarGrilla()

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub CargarGrilla()

        Try

            Dim x As New BE.Cliente
            Dim bx As New BLL.Cliente
            Dim lx As New List(Of BE.ABM)

            If Not IsNothing(dlClientes.SelectedValue) Then
                x.ID = dlClientes.SelectedValue
                lx.Add(x)
                x = bx.ObtenerLista(lx)(0)

                Dim dt As DataTable = New DataTable
                dt.Columns.Add("ID")
                dt.Columns.Add("Nombre")
                dt.Columns.Add("Categoria")
                dt.Columns.Add("Unidades")
                dt.Columns.Add("Monto")

                For Each l As BE.Producto In p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Producto).Cliente.ID = x.ID)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = l.ID
                    dr("Nombre") = l.Nombre
                    dr("Categoria") = l.Categoria.Nombre
                    dr("Unidades") = 0
                    dr("monto") = Double.Parse(0)
                    dt.Rows.Add(dr)
                Next

                grdVentas.DataSource = Nothing
                grdVentas.DataSource = dt
                grdVentas.DataBind()

                If grdVentas.Rows.Count > 0 Then
                    grdVentas.UseAccessibleHeader = True
                    grdVentas.HeaderRow.TableSection = TableRowSection.TableHeader
                End If

                DibujarTorta()

            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
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
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
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


    Protected Sub DibujarGrafica()

        Dim sb As New StringBuilder
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
            sb.AppendLine("            labels: [""Dic"", ""Ene"", ""Feb"", ""Mar"", ""Apr"", ""May"", ""Jun"", ""Jul"", ""Ago"", ""Sep"", ""Oct"", ""Nov""],")
            sb.AppendLine("            datasets: [{")
            sb.AppendLine("                label: """ + Me.grdVentas.Rows(grdVentas.SelectedIndex).Cells(1).Text + """,")
            sb.AppendLine("                //backgroundColor: 'rgb(26, 109, 104)',")
            sb.AppendLine("                borderColor: 'rgb(26, 109, 104)',")
            sb.AppendLine("                data: [1000, 800, 300, 100, 800, 250, 600, 450, 320, 180, 700, 500, 270, 190],")
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

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "dibujarcharts();", True)

        End If

    End Sub



    Protected Sub DibujarTorta()

        Dim sb As New StringBuilder
        sb.Clear()

        sb.AppendLine("<script>")
        sb.AppendLine("window.onload = function dibujartorta() {")
        sb.AppendLine("    var ctx = document.getElementById('torta');")
        sb.AppendLine("    var chart = new Chart(ctx, {")
        sb.AppendLine("        // Tipo de Chart")
        sb.AppendLine("        type: 'doughnut',")
        sb.AppendLine("        // Los datos")
        sb.AppendLine("        data: {")
        sb.AppendLine("            labels: [""Categoria1"", ""Categoria2"", ""Categoria3"", ""Categoria4""],")
        sb.AppendLine("            datasets: [{")
        sb.AppendLine("                label: ""Ventas"",")
        'sb.AppendLine("                //backgroundColor: 'rgb(26, 109, 104)',")
        'sb.AppendLine("                borderColor: 'rgb(26, 109, 104)',")
        sb.AppendLine("                data: [1000, 800, 300, 100],")
        sb.AppendLine("                backgroundColor: [""#ff6384"", ""#36a2eb"", ""#cc65fe"", ""#ffce56""],")
        'sb.AppendLine("                tension: 0.1,")
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
        'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "dibujarcharts();", True)


    End Sub


    Private Sub VtasxCatProd_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        DibujarTorta()
    End Sub
End Class