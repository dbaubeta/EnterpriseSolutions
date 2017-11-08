﻿Imports System.Drawing
Public Class StockLista
    Inherits System.Web.UI.Page



    Dim p As New BLL.Persistencia
    Dim strClase As String = "Producto"

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
                dt.Columns.Add("Stock")

                For Each l As BE.Producto In p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Producto).Cliente.ID = x.ID)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = l.ID
                    dr("Nombre") = l.Nombre
                    dr("Categoria") = l.Categoria.Nombre
                    dr("Stock") = 0
                    dt.Rows.Add(dr)
                Next

                grdStocks.DataSource = Nothing
                grdStocks.DataSource = dt
                grdStocks.DataBind()

                If grdStocks.Rows.Count > 0 Then
                    grdStocks.UseAccessibleHeader = True
                    grdStocks.HeaderRow.TableSection = TableRowSection.TableHeader
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
            For Each r As GridViewRow In Me.grdStocks.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdStocks, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdStocks.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdStocks.Rows
                If row.RowIndex = grdStocks.SelectedIndex Then
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

        sb.AppendLine("<script>")
        sb.AppendLine("function dibujarchart() {")
        sb.AppendLine("    var ctx = document.getElementById('myChart');")
        sb.AppendLine("    var chart = new Chart(ctx, {")
        sb.AppendLine("        // Tipo de Chart")
        sb.AppendLine("        type: 'line',")
        sb.AppendLine("        // Los datos")
        sb.AppendLine("        data: {")
        sb.AppendLine("            labels: [""Dic"", ""Ene"", ""Feb"", ""Mar"", ""Apr"", ""May"", ""Jun"", ""Jul"", ""Ago"", ""Sep"", ""Oct"", ""Nov""],")
        sb.AppendLine("            datasets: [{")
        sb.AppendLine("                label: ""Stock"",")
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

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "dibujarchart();", True)


    End Sub

End Class