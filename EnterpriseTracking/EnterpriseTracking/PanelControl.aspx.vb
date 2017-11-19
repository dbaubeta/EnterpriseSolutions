Imports System.Drawing

Public Class PanelControl
    Inherits System.Web.UI.Page

    Dim p As New BLL.Persistencia
    Dim strClase As String = "Transmisiones"
    Dim Fechajustificacion As Date
    Dim DistribuidorJustificacion As Long
    Dim f As New BLL.Facade_Pantalla

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Dim b As New BLL.Cliente

        Try
            If Not IsPostBack Then

                Me.dlano.Items.Add(Now.Year.ToString)
                Me.dlano.Items.Add((Now.Year - 1).ToString)
                Me.dlano.Items.Add((Now.Year - 2).ToString)
                Me.dlano.Items.Add((Now.Year - 3).ToString)
                Me.dlano.Items.Add((Now.Year - 4).ToString)
                Me.dlano.SelectedValue = (Now.Year.ToString)
                CargarMeses()


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
            Dim bf As New BLL.Factura
            Dim bj As New BLL.Justificacion
            Dim bp As New BLL.Producto
            Dim bd As New BLL.Distribuidor

            If Not IsNothing(dlClientes.SelectedValue) Then
                x.ID = dlClientes.SelectedValue
                lx.Add(x)
                x = bx.ObtenerLista(lx)(0)

                'Creo la tabla para el data bind
                Dim dt As DataTable = New DataTable
                dt.Columns.Add("ID")
                dt.Columns.Add("Distribuidor")

                'Seteo los valores desde hasta, en base al mes y año
                Dim desde As New BE.Factura
                Dim hasta As New BE.Factura
                desde.Fecha = Convert.ToDateTime(New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, 1))
                hasta.Fecha = Convert.ToDateTime(New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, Date.DaysInMonth(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1)))
                If hasta.Fecha.Date >= Now.Date Then hasta.Fecha = Now.Date

                Dim desdej As New BE.Justificacion
                Dim hastaj As New BE.Justificacion
                desdej.Fecha = desde.Fecha
                hastaj.Fecha = hasta.Fecha

                ' Cargo la grilla
                For Each d In bd.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = x.ID)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = d.ID
                    dr("Distribuidor") = d.Nombre
                    dt.Rows.Add(dr)
                Next

                grdTransmisiones.DataSource = Nothing
                grdTransmisiones.DataSource = dt
                grdTransmisiones.DataBind()


                'Recorro la grilla asignando las imagenes a los botones de cada dia.
                For Each gr As GridViewRow In grdTransmisiones.Rows

                    ' SETEO % TRANSMISIONES
                    ' ============================================================================================================================================================
                    Dim did As Long = Long.Parse(grdTransmisiones.DataKeys(gr.RowIndex).Value)
                    desde.Distribuidor.ID = did
                    desdej.Distribuidor.ID = did

                    'Calculo porcentaje y meto en el div
                    Dim porcentaje As Integer = bf.CalcularPorcentajeTransmisiones(desde, hasta)

                    Dim tipobarra As String = "progress-bar-success"
                    If porcentaje < 100 Then tipobarra = "progress-bar-warning"
                    If porcentaje < 50 Then tipobarra = "progress-bar-danger"

                    Dim sb As New StringBuilder
                    sb.Clear()

                    sb.AppendLine("<div class=""progress"" style=""height:100%"">")
                    sb.AppendLine("<div class=""progress-bar " + tipobarra + """ role=""progressbar"" aria-valuenow=""" + porcentaje.ToString + """")
                    sb.AppendLine("aria-valuemin=""0"" aria-valuemax=""100"" style=""width:" + porcentaje.ToString + "%; height:100%"">")
                    sb.AppendLine(porcentaje.ToString + "%")
                    sb.AppendLine("</div>")
                    sb.AppendLine("</div>")

                    DirectCast(gr.FindControl("LitPorcentaje"), Literal).Text = sb.ToString


                    ' SETEO INVASION
                    ' ===============================================================================================
                    Dim hayinvasion As Boolean = False
                    Dim lf As List(Of BE.Factura) = bf.ObtenerFacturas(desde, hasta).FindAll(Function(z) DirectCast(z, BE.Factura).Distribuidor.ID = did)
                    For Each fact As BE.Factura In lf
                        If fact.PuntoVenta.invade Then
                            hayinvasion = True
                        End If
                    Next
                    If hayinvasion Then
                        DirectCast(gr.FindControl("ImgInvasion"), ImageButton).ImageUrl = "Images/error.png"
                    Else
                        DirectCast(gr.FindControl("ImgInvasion"), ImageButton).ImageUrl = "Images/success_small.png"
                    End If

                    ' SETEO STOCK CRITICO
                    ' ===============================================================================================
                    DirectCast(gr.FindControl("ImgStockCritico"), ImageButton).ImageUrl = "Images/success_small.png"

                    Dim lp As List(Of BE.ABM) = bp.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Producto).Cliente.ID = x.ID)
                    For Each p As BE.Producto In lp
                        ' Hay que agregar una manera de saber que no tiene ningun movimiento , con un -1 por ejemplo y evitar que salte error por esa condicion
                        Dim st As New BLL.Stock
                        Dim hastast As New BE.Stock
                        hastast.Distribuidor.ID = did
                        hastast.Fecha = hasta.Fecha
                        Dim sum = st.CalcularStock(hastast, p)
                        If sum.Cantidad < p.stockminimo Then
                            DirectCast(gr.FindControl("ImgStockCritico"), ImageButton).ImageUrl = "Images/error.png"
                            Exit For
                        End If

                    Next

                Next

                If grdTransmisiones.Rows.Count > 0 Then
                    grdTransmisiones.UseAccessibleHeader = True
                    grdTransmisiones.HeaderRow.TableSection = TableRowSection.TableHeader
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
            For Each r As GridViewRow In Me.grdTransmisiones.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    'r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdTransmisiones, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdTransmisiones.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdTransmisiones.Rows
                If row.RowIndex = grdTransmisiones.SelectedIndex Then
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                    row.ToolTip = String.Empty
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


    Protected Sub ImagenClick(sender As Object, e As EventArgs)

        Dim button As ImageButton = DirectCast(sender, ImageButton)


        If button.ImageUrl = "~/Images/error.png" Then

            Session("DistribuidorJustificacion") = Long.Parse(grdTransmisiones.Rows(Convert.ToInt32(button.CommandArgument) - 1).Cells(0).Text)
            Session("Fechajustificacion") = New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, Int32.Parse(button.ID.Replace("idia", "")))
            Me.noTranslateModalDistribuidorJustificacion.Text = grdTransmisiones.Rows(Convert.ToInt32(button.CommandArgument) - 1).Cells(1).Text
            Me.noTranslateModalFechaJustificacion.Text = DirectCast(Session("Fechajustificacion"), Date).ToString("yyyy-MM-dd")
            Me.txtjustificacion.Text = ""
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalJustificacion();", True)

        ElseIf button.ImageUrl = "~/Images/justificado.png" Then

            Session("DistribuidorJustificacion") = Long.Parse(grdTransmisiones.Rows(Convert.ToInt32(button.CommandArgument) - 1).Cells(0).Text)
            Session("Fechajustificacion") = New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, Int32.Parse(button.ID.Replace("idia", "")))
            Me.noTranslateModalMessageSiNo.Text = f.ObtenerLeyenda(New BE.MensajeError("SeguroBorrarJustificacion"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + DirectCast(Session("Fechajustificacion"), Date).ToString("yyyy-MM-dd")
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalSiNo();", True)


        End If
    End Sub


    Public Sub Aceptar_Click()
        If txtjustificacion.Text = "" Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalJustificacion();", True)
        Else
            Dim j As New BE.Justificacion
            Dim bj As New BLL.Justificacion
            j.Distribuidor = New BE.Distribuidor
            j.Distribuidor.ID = DirectCast(Session("DistribuidorJustificacion"), Long)
            j.Fecha = DirectCast(Session("Fechajustificacion"), Date)
            j.Motivo = txtjustificacion.Text
            bj.Guardar(j)
            If Me.dlClientes.Items.Count > 0 Then CargarGrilla()
        End If


    End Sub

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

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Dim j As New BE.Justificacion
        Dim bj As New BLL.Justificacion
        j.Distribuidor = New BE.Distribuidor
        j.Distribuidor.ID = DirectCast(Session("DistribuidorJustificacion"), Long)
        j.Fecha = DirectCast(Session("Fechajustificacion"), Date)
        bj.Eliminar(j)
        If Me.dlClientes.Items.Count > 0 Then CargarGrilla()

    End Sub
End Class