Imports System.Drawing

Public Class ValStock
    Inherits System.Web.UI.Page


    Dim p As New BLL.Persistencia
    Dim strClase As String = "Producto"
    Dim bs As New BLL.Stock


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

                If dlClientes.Items.Count > 0 Then CargardlDistribuidores()
                If Me.dlClientes.Items.Count > 0 Then CargarGrilla()

            Else
                CalendarExtender1.SelectedDate = DateTime.ParseExact(Me.txtFecha.Text, CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture))

            End If

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub CargardlDistribuidores()

        Dim b As New BLL.Distribuidor
        Me.dlDistribuidores.Items.Clear()
        Me.dlDistribuidores.DataValueField = "ID"
        Me.dlDistribuidores.DataTextField = "Nombre"
        Me.dlDistribuidores.DataSource = b.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = dlClientes.SelectedValue)
        Me.dlDistribuidores.DataBind()
        If Me.dlDistribuidores.Items.Count > 0 Then Me.dlDistribuidores.SelectedIndex = 0

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
                dt.Columns.Add("Nombre")
                dt.Columns.Add("Categoria")
                dt.Columns.Add("Stock")
                dt.Columns.Add("ValStock")

                For Each l As BE.Producto In p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Producto).Cliente.ID = x.ID)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = l.ID
                    dr("Nombre") = l.Nombre
                    dr("Categoria") = l.Categoria.Nombre
                    Dim st As New BLL.Stock
                    Dim hastast As New BE.Stock
                    hastast.Distribuidor.ID = dlDistribuidores.SelectedValue
                    hastast.Fecha = Me.CalendarExtender1.SelectedDate
                    Dim resultado As BE.Stock = st.ValorizarFIFO(hastast, l)
                    dr("Stock") = resultado.Cantidad
                    dr("ValStock") = resultado.Precio
                    dt.Rows.Add(dr)
                Next

                grdStocksVal.DataSource = Nothing
                grdStocksVal.DataSource = dt
                grdStocksVal.DataBind()

                If grdStocksVal.Rows.Count > 0 Then
                    grdStocksVal.UseAccessibleHeader = True
                    grdStocksVal.HeaderRow.TableSection = TableRowSection.TableHeader
                End If

            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Try
            For Each r As GridViewRow In Me.grdStocksVal.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdStocksVal, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdStocksVal.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdStocksVal.Rows
                If row.RowIndex = grdStocksVal.SelectedIndex Then
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                    row.ToolTip = String.Empty

                    Dim p As New BE.Producto
                    Dim bp As New BLL.Producto
                    Dim lp As New List(Of BE.ABM)
                    lp.Add(p)
                    p.ID = Long.Parse(grdStocksVal.DataKeys(row.RowIndex).Value)
                    p = bp.ObtenerLista(lp).Find(Function(z) DirectCast(z, BE.Producto).Cliente.ID = dlClientes.SelectedValue)
                    If Not IsNothing(p) Then
                        DibujarGrafica(p)
                    End If
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "clickenfila();", True)
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


    Protected Sub DibujarGrafica(p As BE.Producto)

        Dim sb As New StringBuilder
        Dim stocks(11) As Long


        Dim datastr As String = "                data: ["
        Dim labelsstr As String = "                labels: ["""
        Dim fechainicio As Date = Me.CalendarExtender1.SelectedDate
        For i = 11 To 0 Step -1
            Dim st As New BLL.Stock
            Dim hastast As New BE.Stock
            hastast.Distribuidor.ID = dlDistribuidores.SelectedValue
            hastast.Fecha = fechainicio.AddMonths(i * -1)
            If hastast.Fecha <> fechainicio Then
                hastast.Fecha = ObtenerUltimodia(hastast.Fecha)
            End If
            datastr += st.CalcularStock(hastast, p).Cantidad.ToString
            labelsstr += obtenertextomes(hastast.Fecha.Month)
            If i = 0 Then datastr += "]," Else datastr += ","
            If i = 0 Then labelsstr += """]," Else labelsstr += ""","""
        Next


        sb.Clear()

        sb.AppendLine("<script>")
        sb.AppendLine("function dibujarchart() {")
        sb.AppendLine("    var ctx = document.getElementById('myChart');")
        sb.AppendLine("    var chart = new Chart(ctx, {")
        sb.AppendLine("        // Tipo de Chart")
        sb.AppendLine("        type: 'line',")
        sb.AppendLine("        // Los datos")
        sb.AppendLine("        data: {")

        sb.AppendLine(labelsstr)

        sb.AppendLine("            datasets: [{")
        sb.AppendLine("                label: ""Stock"",")
        sb.AppendLine("                //backgroundColor: 'rgb(26, 109, 104)',")
        sb.AppendLine("                borderColor: 'rgb(26, 109, 104)',")

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

        'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "dibujarchart();", True)


    End Sub

    Private Sub StockLista_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Me.CalendarExtender1.Format = Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern


    End Sub

    Private Sub dlDistribuidores_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlDistribuidores.SelectedIndexChanged

        If Me.dlClientes.Items.Count > 0 And Me.dlDistribuidores.Items.Count > 0 Then CargarGrilla()

    End Sub


    Private Function ObtenerUltimodia(fecha As DateTime) As DateTime
        Return New DateTime(fecha.Year, fecha.Month, DateTime.DaysInMonth(fecha.Year, fecha.Month))
    End Function


    Private Function obtenertextomes(mes As Integer) As String

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
        Return f.ObtenerLeyenda(New BE.MensajeError(strbusqueda), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda


    End Function

End Class