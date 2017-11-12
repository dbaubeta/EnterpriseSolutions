Imports System.Drawing

Public Class TransmisionesLista
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

                Me.noTranslateFactFaltante.Text = f.ObtenerLeyenda(New BE.MensajeError("noTranslateFactFaltante"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                Me.noTranslateFactPresente.Text = f.ObtenerLeyenda(New BE.MensajeError("noTranslateFactPresente"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                Me.noTranslateJustificado.Text = f.ObtenerLeyenda(New BE.MensajeError("noTranslateJustificado"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda


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
                p.EstablecerObjetoNegocio(New BLL.Distribuidor)
                For Each d In p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = x.ID)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = d.ID
                    dr("Distribuidor") = d.Nombre
                    dt.Rows.Add(dr)
                Next

                noTranslategrdTransmisiones.DataSource = Nothing
                noTranslategrdTransmisiones.DataSource = dt
                noTranslategrdTransmisiones.DataBind()


                'Recorro la grilla asignando las imagenes a los botones de cada dia.
                For Each gr As GridViewRow In noTranslategrdTransmisiones.Rows
                    Dim did As Long = Long.Parse(gr.Cells(0).Text)
                    desde.Distribuidor.ID = did
                    desdej.Distribuidor.ID = did
                    Dim lf As List(Of BE.Factura) = bf.ObtenerFacturas(desde, hasta).FindAll(Function(z) DirectCast(z, BE.Factura).Distribuidor.ID = did)
                    Dim lj As List(Of BE.Justificacion) = bj.Obtenerjustificaciones(desdej, hastaj).FindAll(Function(z) DirectCast(z, BE.Justificacion).Distribuidor.ID = did)
                    For idx = 1 To 31
                        Dim dia As Integer = idx
                        If idx <= hasta.Fecha.Day Then
                            DirectCast(gr.FindControl("idia" + (dia).ToString), ImageButton).ImageUrl = "~/Images/nada.png"
                            If DirectCast(p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).ID = did)(0), BE.Distribuidor).diasfactura.Substring(Int32.Parse(New DateTime(desde.Fecha.Year, desde.Fecha.Month, dia).DayOfWeek), 1) = "1" Then

                                If IsNothing(lf.Find(Function(y) y.Fecha.Date = New DateTime(desde.Fecha.Year, desde.Fecha.Month, dia).Date)) Then
                                    Dim jus As BE.Justificacion = lj.Find(Function(y) y.Fecha.Date = New DateTime(desde.Fecha.Year, desde.Fecha.Month, dia).Date)
                                    If IsNothing(jus) Then
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).ImageUrl = "~/Images/error.png"
                                    Else
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).ImageUrl = "~/Images/justificado.png"
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("data-toggle", "popover")
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("data-trigger", "hover focus")
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("data-html", "true")
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("data-container", "body")
                                        If dia > 15 Then
                                            DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("placement", "left")
                                        Else
                                            DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("placement", "right")

                                        End If
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("title", "<b>" + f.ObtenerLeyenda(New BE.MensajeError("Justificado:"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda + "</b>")
                                        DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).Attributes.Add("data-content", jus.Motivo + "<br><br>" + f.ObtenerLeyenda(New BE.MensajeError("ClickParaEliminarJustificacion"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                                    End If
                                Else
                                    DirectCast(gr.FindControl("idia" + dia.ToString), ImageButton).ImageUrl = "~/Images/Success.png"
                                End If
                            End If
                        Else
                            DirectCast(gr.FindControl("idia" + (dia).ToString), ImageButton).ImageUrl = "~/Images/nada.png"
                            ' Oculto la columna
                        End If

                    Next
                Next

                Dim leyendasdias(6) As String
                leyendasdias(0) = f.ObtenerLeyenda(New BE.MensajeError("DomingoCorto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                leyendasdias(1) = f.ObtenerLeyenda(New BE.MensajeError("LunesCorto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                leyendasdias(2) = f.ObtenerLeyenda(New BE.MensajeError("MartesCorto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                leyendasdias(3) = f.ObtenerLeyenda(New BE.MensajeError("MiercolesCorto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                leyendasdias(4) = f.ObtenerLeyenda(New BE.MensajeError("JuevesCorto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                leyendasdias(5) = f.ObtenerLeyenda(New BE.MensajeError("ViernesCorto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                leyendasdias(6) = f.ObtenerLeyenda(New BE.MensajeError("SabadoCorto"), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda
                If noTranslategrdTransmisiones.Rows.Count > 0 Then
                    For i = 2 To noTranslategrdTransmisiones.Columns.Count - 1
                        If (i - 1) <= Date.DaysInMonth(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1) Then
                            noTranslategrdTransmisiones.Columns(i).Visible = True
                            noTranslategrdTransmisiones.HeaderRow.Cells(i).Text = leyendasdias(Int32.Parse(New DateTime(desde.Fecha.Year, desde.Fecha.Month, i - 1).DayOfWeek)) + Environment.NewLine + (i - 1).ToString
                        Else
                            noTranslategrdTransmisiones.Columns(i).Visible = False
                        End If
                    Next
                End If



                If noTranslategrdTransmisiones.Rows.Count > 0 Then
                    noTranslategrdTransmisiones.UseAccessibleHeader = True
                    noTranslategrdTransmisiones.HeaderRow.TableSection = TableRowSection.TableHeader
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
            For Each r As GridViewRow In Me.noTranslategrdTransmisiones.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    'r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.noTranslategrdTransmisiones, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles noTranslategrdTransmisiones.SelectedIndexChanged

        Try
            For Each row As GridViewRow In noTranslategrdTransmisiones.Rows
                If row.RowIndex = noTranslategrdTransmisiones.SelectedIndex Then
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

            Session("DistribuidorJustificacion") = Long.Parse(noTranslategrdTransmisiones.Rows(Convert.ToInt32(button.CommandArgument) - 1).Cells(0).Text)
            Session("Fechajustificacion") = New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, Int32.Parse(button.ID.Replace("idia", "")))
            Me.noTranslateModalDistribuidorJustificacion.Text = noTranslategrdTransmisiones.Rows(Convert.ToInt32(button.CommandArgument) - 1).Cells(1).Text
            Me.noTranslateModalFechaJustificacion.Text = DirectCast(Session("Fechajustificacion"), Date).ToString("yyyy-MM-dd")
            Me.txtjustificacion.Text = ""
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalJustificacion();", True)

        ElseIf button.ImageUrl = "~/Images/justificado.png" Then

            Session("DistribuidorJustificacion") = Long.Parse(noTranslategrdTransmisiones.Rows(Convert.ToInt32(button.CommandArgument) - 1).Cells(0).Text)
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

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Dim j As New BE.Justificacion
        Dim bj As New BLL.Justificacion
        j.Distribuidor = New BE.Distribuidor
        j.Distribuidor.ID = DirectCast(Session("DistribuidorJustificacion"), Long)
        j.Fecha = DirectCast(Session("Fechajustificacion"), Date)
        bj.Eliminar(j)
        If Me.dlClientes.Items.Count > 0 Then CargarGrilla()

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