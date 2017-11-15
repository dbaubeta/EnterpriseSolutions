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

                Me.CalendarExtender1.EndDate = Now.Date
                Me.CalendarExtender1.SelectedDate = Now.Date

                If dlClientes.Items.Count > 0 Then CargardlDistribuidores()

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
                    hastast.Fecha = Me.CalendarExtender1.SelectedDate
                    Dim historial(11) As Long
                    historial = obtenerHistorial(hastast, l)
                    Dim med As Long = Mediana(historial)
                    Dim prommes As Integer = PromedioMeses(historial)
                    Dim proyeccion(11) As Long
                    proyeccion = proyectar(historial, med, prommes)

                    dr("mes1") = proyeccion(0)
                    dr("mes2") = proyeccion(1)
                    dr("mes3") = proyeccion(2)
                    dr("mes4") = proyeccion(3)
                    dr("mes5") = proyeccion(4)
                    dr("mes6") = proyeccion(5)
                    dr("mes7") = proyeccion(6)
                    dr("mes8") = proyeccion(7)
                    dr("mes9") = proyeccion(8)
                    dr("mes10") = proyeccion(9)
                    dr("mes11") = proyeccion(10)
                    dr("mes12") = proyeccion(11)

                    dt.Rows.Add(dr)
                Next

                noTranslategrdProyeccion.DataSource = Nothing
                noTranslategrdProyeccion.DataSource = dt
                noTranslategrdProyeccion.DataBind()

                If noTranslategrdProyeccion.Rows.Count > 0 Then
                    noTranslategrdProyeccion.UseAccessibleHeader = True
                    noTranslategrdProyeccion.HeaderRow.TableSection = TableRowSection.TableHeader
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
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
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
        Dim datastr2 As String = "                data: ["
        Dim labelsstr2 As String = "                labels: ["""



        Dim hastast As New BE.Stock
        hastast.Distribuidor.ID = dlDistribuidores.SelectedValue
        hastast.Fecha = Me.CalendarExtender1.SelectedDate
        Dim historial(11) As Long
        historial = obtenerHistorial(hastast, p)
        Dim med As Long = Mediana(historial)
        Dim prommes As Integer = PromedioMeses(historial)
        Dim proyeccion(11) As Long
        proyeccion = proyectar(historial, med, prommes)

        Dim fechainicio As Date = Now.Date.AddMonths(-11)
        For i = 0 To 23
            If i <= 11 Then
                datastr += historial(i).ToString
                datastr2 += "0"
            Else
                datastr += "0"
                datastr2 += proyeccion(i - 12).ToString
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
        Return f.ObtenerLeyenda(New BE.MensajeError(strbusqueda + "corto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda


    End Function

    Private Sub btnProcesar_Click(sender As Object, e As EventArgs) Handles btnProcesar.Click
        If Me.dlClientes.Items.Count > 0 And Me.dlDistribuidores.Items.Count > 0 Then CargarGrilla()
    End Sub


    Public Function obtenerHistorial(fecha As BE.Stock, prod As BE.Producto) As Long()

        Dim bf As New BLL.Factura
        Dim bdf As New BLL.Detalle_Factura
        Dim bp As New BLL.Producto
        Dim bd As New BLL.Distribuidor
        Dim bs As New BLL.Stock
        Dim salida As New BE.Stock

        Dim historial(11) As Long

        Dim ldi As New List(Of BE.ABM)
        ldi.Add(fecha.Distribuidor)
        fecha.Distribuidor = bd.ObtenerLista(ldi)(0)

        Dim ld As New List(Of BE.ABM)
        ld.Add(prod)
        prod = bp.ObtenerLista(ld).Find(Function(z) DirectCast(z, BE.Producto).Cliente.ID = fecha.Distribuidor.Cliente.ID)

        'Seteo los valores desde hasta, en base al mes y año
        Dim desde As New BE.Stock
        Dim hasta As New BE.Stock
        desde.Fecha = New Date(Now.Year, Now.Month, 1).AddMonths(-11)
        desde.Distribuidor = fecha.Distribuidor
        hasta.Fecha = fecha.Fecha
        If hasta.Fecha.Date >= Now.Date Then hasta.Fecha = Now.Date

        Dim ls As List(Of BE.Stock) = bs.ObtenerStocks(desde, hasta).FindAll(Function(z) DirectCast(z, BE.Stock).Distribuidor.ID = fecha.Distribuidor.ID).FindAll(Function(zz) DirectCast(zz, BE.Stock).Producto.ID = prod.ID).FindAll(Function(zzz) zzz.Tipo = "Entrada")
        Dim fechacontrol As Date = New Date(Now.Year, Now.Month, 1).AddMonths(1)
        For Each s As BE.Stock In ls
            Dim difmonth As Integer = Math.Floor(Math.Abs(DateDiff(DateInterval.Month, fechacontrol, s.Fecha)))
            historial(12 - difmonth) += s.Cantidad
        Next

        Return historial

    End Function


    Private Function Mediana(ByVal historial As Long()) As Long

        Dim cntnon0 As Integer = 0
        For i = 0 To 11
            If historial(i) <> 0 Then cntnon0 += 1
        Next
        Dim values(cntnon0 - 1)

        Dim idx As Integer = 0
        For i = 0 To 11
            If historial(i) <> 0 Then
                values(idx) = historial(i)
                idx += 1
            End If
        Next

        If values.Length >= 5 Then 'Usar MEdiana si hay menos de 5 valores para calcular
            Array.Sort(values)
            Dim size As Integer = values.Length
            If size = 0 Then Return 0

            If size Mod 2 = 0 Then
                Return (values(CInt(size / 2) - 1) + values(CInt(size / 2))) / 2
            Else
                Return values(CInt(Math.Floor(size / 2)))
            End If
        Else ' Usar Promedio

            Dim lCounter As Long
            Dim dTotal As Double
            dTotal = 0
            For lCounter = 0 To UBound(values)
                dTotal = dTotal + values(lCounter)
            Next
            Return dTotal / (UBound(values) + 1)

        End If


    End Function


    Private Function PromedioMeses(ByVal historial As Long()) As Long

        Dim cntnon0 As Integer = 0
        Dim cnt0 As Integer = 0
        For i = 0 To 11
            If historial(i) <> 0 Then
                cntnon0 += 1
            Else
                cnt0 += 1
            End If
        Next

        Return Convert.ToInt32(Math.Round((cnt0 / (cntnon0 + 1))))

    End Function


    Private Function proyectar(historial As Long(), med As Long, prommes As Integer) As Long()

        Dim proyeccion(11) As Long
        Dim cnt0 As Integer = 0
        Dim inicio As Integer = 0

        For i = 11 To 0 Step -1
            If historial(i) = 0 Then
                cnt0 += 1
            Else
                Exit For
            End If
        Next

        inicio = prommes - cnt0
        If inicio < 0 Then inicio = 0

        For i = 0 To 11
            If i = inicio Then
                proyeccion(i) = med
                inicio += prommes + 1
            End If
        Next

        Return proyeccion

    End Function



End Class