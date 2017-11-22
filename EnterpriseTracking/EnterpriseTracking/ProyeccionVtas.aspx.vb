Imports System.Drawing

Public Class ProyeccionVtas
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

                'Me.CalendarExtender1.EndDate = Now.Date
                'Me.CalendarExtender1.SelectedDate = Now.Date

                If dlClientes.Items.Count > 0 Then CargardlDistribuidores()

            Else
                'CalendarExtender1.SelectedDate = DateTime.ParseExact(Me.txtFecha.Text, CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture))

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
                dt.Columns.Add("mes1")
                dt.Columns.Add("mes2")
                dt.Columns.Add("mes3")
                dt.Columns.Add("mes4")
                dt.Columns.Add("mes5")
                dt.Columns.Add("mes6")
                dt.Columns.Add("mes7")
                dt.Columns.Add("mes8")
                dt.Columns.Add("mes9")
                dt.Columns.Add("mes10")
                dt.Columns.Add("mes11")
                dt.Columns.Add("mes12")

                For Each l As BE.Producto In p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Producto).Cliente.ID = x.ID)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = l.ID
                    dr("Nombre") = l.Nombre
                    Dim hastast As New BE.Stock
                    hastast.Distribuidor.ID = dlDistribuidores.SelectedValue
                    hastast.Fecha = Now.Date 'Me.CalendarExtender1.SelectedDate

                    Dim bst As New BLL.Stock

                    Dim proyeccion(23) As BE.Stock
                    proyeccion = bst.ProyectarVentas(hastast, l)
                    If proyeccion(0).Cantidad <> -1 Then
                        dr("mes1") = proyeccion(12).Cantidad
                        dr("mes2") = proyeccion(13).Cantidad
                        dr("mes3") = proyeccion(14).Cantidad
                        dr("mes4") = proyeccion(15).Cantidad
                        dr("mes5") = proyeccion(16).Cantidad
                        dr("mes6") = proyeccion(17).Cantidad
                        dr("mes7") = proyeccion(18).Cantidad
                        dr("mes8") = proyeccion(19).Cantidad
                        dr("mes9") = proyeccion(20).Cantidad
                        dr("mes10") = proyeccion(21).Cantidad
                        dr("mes11") = proyeccion(22).Cantidad
                        dr("mes12") = proyeccion(23).Cantidad
                    End If
                    dt.Rows.Add(dr)
                Next


                noTranslategrdProyeccion.DataSource = Nothing
                noTranslategrdProyeccion.DataSource = dt
                noTranslategrdProyeccion.DataBind()

                If noTranslategrdProyeccion.Rows.Count > 0 Then
                    noTranslategrdProyeccion.UseAccessibleHeader = True
                    noTranslategrdProyeccion.HeaderRow.TableSection = TableRowSection.TableHeader
                End If


                For i = 1 To 12

                    Me.noTranslategrdProyeccion.HeaderRow.Cells(i).Text = obtenertextomes((Now.Date.AddMonths(i)).Month) + " " + (Now.Date.AddMonths(i)).Year.ToString

                Next

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
            For Each r As GridViewRow In Me.noTranslategrdProyeccion.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.noTranslategrdProyeccion, "Select$" + r.RowIndex.ToString, True)
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

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles noTranslategrdProyeccion.SelectedIndexChanged

        Try
            For Each row As GridViewRow In noTranslategrdProyeccion.Rows
                If row.RowIndex = noTranslategrdProyeccion.SelectedIndex Then
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                    row.ToolTip = String.Empty

                    Dim p As New BE.Producto
                    Dim bp As New BLL.Producto
                    Dim lp As New List(Of BE.ABM)
                    lp.Add(p)
                    p.ID = Long.Parse(noTranslategrdProyeccion.DataKeys(row.RowIndex).Value)
                    p = bp.ObtenerLista(lp).Find(Function(z) DirectCast(z, BE.Producto).Cliente.ID = dlClientes.SelectedValue)
                    If Not IsNothing(p) Then
                        DibujarGrafica(p)
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "clickenfila();", True)
                    End If

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


    Protected Sub DibujarGrafica(p As BE.Producto)

        Dim sb As New StringBuilder
        Dim stocks(11) As Long

        Dim datastr As String = "                data: ["
        Dim labelsstr As String = "                labels: ["""
        Dim datastr2 As String = "                data: ["
        Dim labelsstr2 As String = "                labels: ["""



        Dim hastast As New BE.Stock
        hastast.Distribuidor.ID = dlDistribuidores.SelectedValue
        hastast.Fecha = Now.Date 'Me.CalendarExtender1.SelectedDate

        Dim bst As New BLL.Stock
        Dim proyeccion(23) As BE.Stock
        proyeccion = bst.ProyectarVentas(hastast, p)

        If proyeccion(0).Cantidad <> -1 Then

            Dim fechainicio As Date = Now.Date.AddMonths(-11)
            For i = 0 To 23
                If i <= 11 Then
                    datastr += proyeccion(i).Cantidad.ToString
                    datastr2 += "0"
                Else
                    datastr += "0"
                    datastr2 += proyeccion(i).Cantidad.ToString
                End If
                labelsstr += obtenertextomes((fechainicio.AddMonths(i)).Month) + " " + (fechainicio.AddMonths(i)).Year.ToString
                If i = 23 Then datastr += "]," Else datastr += ","
                If i = 23 Then datastr2 += "]," Else datastr2 += ","
                If i = 23 Then labelsstr += """]," Else labelsstr += ""","""
            Next

            sb.Clear()

            sb.AppendLine("<script>")
            sb.AppendLine("function dibujarchart() {")
            sb.AppendLine("    var ctx = document.getElementById('myChart');")
            sb.AppendLine("    var chart = new Chart(ctx, {")
            sb.AppendLine("        // Tipo de Chart")
            sb.AppendLine("        type: 'bar',")
            sb.AppendLine("        // Los datos")
            sb.AppendLine("        data: {")

            sb.AppendLine(labelsstr)

            sb.AppendLine("            datasets: [{")
            sb.AppendLine("                label: """ + "historial" + """,")
            sb.AppendLine("                backgroundColor: 'rgba(63, 142, 191, 0.75)',")
            sb.AppendLine("                borderColor: 'rgba(0, 66, 107, 1)',")

            sb.AppendLine(datastr)

            sb.AppendLine("            } ,")
            sb.AppendLine("                {label: """ + "proyeccion" + """,")
            sb.AppendLine("                backgroundColor: 'rgba(178, 28, 28, 0.75)',")
            sb.AppendLine("                borderColor: 'rgb(178, 28, 28)',")

            sb.AppendLine(datastr2)

            sb.AppendLine("            }]")
            sb.AppendLine("        },")
            sb.AppendLine("        // Opciones para el chart")
            sb.AppendLine("        options: {")
            sb.AppendLine("            responsive: true,")
            sb.AppendLine("            maintainAspectRatio: false,")
            sb.AppendLine("            animation: {duration: 1000},")
            sb.AppendLine("            scales: {xAxes: [{stacked: true}],yAxes: [{stacked: true}]}")
            sb.AppendLine("        }")
            sb.AppendLine("    });")
            sb.AppendLine("}")
            sb.AppendLine("</script>")


            LitChart.Text = sb.ToString
        Else
            LitChart.Text = ""
        End If

    End Sub

    Private Sub StockLista_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        'Me.CalendarExtender1.Format = Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern


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
        Return f.ObtenerLeyenda(New BE.MensajeError(strbusqueda + "corto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda


    End Function

    Private Sub btnProcesar_Click(sender As Object, e As EventArgs) Handles btnProcesar.Click
        If Me.dlClientes.Items.Count > 0 And Me.dlDistribuidores.Items.Count > 0 Then CargarGrilla()
    End Sub


    Private Sub dlClientes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlClientes.SelectedIndexChanged

        CargardlDistribuidores()

    End Sub



End Class