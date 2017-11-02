Imports System.Drawing

Public Class TransmisionesLista
    Inherits System.Web.UI.Page


    Dim p As New BLL.Persistencia
    Dim strClase As String = "Transmisiones"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim f As New BLL.Facade_Pantalla

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Dim b As New BLL.Cliente

        Try
            If Not IsPostBack Then

                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Enero", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Febrero", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Marzo", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Abril", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Mayo", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Junio", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Julio", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Agosto", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Septiembre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Octubre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Noviembre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlmes.Items.Add(f.ObtenerLeyenda(New BE.MensajeError("Diciembre", ""), DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda)
                Me.dlano.Items.Add("2017")
                Me.dlano.Items.Add("2016")
                Me.dlano.SelectedIndex = 0
                Me.dlmes.SelectedIndex = 0

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

            If Not IsNothing(dlClientes.SelectedValue) Then
                x.ID = dlClientes.SelectedValue
                lx.Add(x)
                x = bx.ObtenerLista(lx)(0)

                Dim dt As DataTable = New DataTable
                dt.Columns.Add("Distribuidor")
                dt.Columns.Add("dia01")
                dt.Columns.Add("dia02")
                dt.Columns.Add("dia03")
                dt.Columns.Add("dia04")
                dt.Columns.Add("dia05")
                dt.Columns.Add("dia06")
                dt.Columns.Add("dia07")
                dt.Columns.Add("dia08")
                dt.Columns.Add("dia09")
                dt.Columns.Add("dia10")
                dt.Columns.Add("dia11")
                dt.Columns.Add("dia12")
                dt.Columns.Add("dia13")
                dt.Columns.Add("dia14")
                dt.Columns.Add("dia15")
                dt.Columns.Add("dia16")
                dt.Columns.Add("dia17")
                dt.Columns.Add("dia18")
                dt.Columns.Add("dia19")
                dt.Columns.Add("dia20")
                dt.Columns.Add("dia21")
                dt.Columns.Add("dia22")
                dt.Columns.Add("dia23")
                dt.Columns.Add("dia24")
                dt.Columns.Add("dia25")
                dt.Columns.Add("dia26")
                dt.Columns.Add("dia27")
                dt.Columns.Add("dia28")
                dt.Columns.Add("dia29")
                dt.Columns.Add("dia30")
                dt.Columns.Add("dia31")

                Dim desde As New BE.Factura
                Dim hasta As New BE.Factura

                desde.Fecha = Convert.ToDateTime(New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, 1))
                hasta.Fecha = Convert.ToDateTime(New Date(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1, Date.DaysInMonth(Int32.Parse(Me.dlano.SelectedItem.Text), Me.dlmes.SelectedIndex + 1)))

                p.EstablecerObjetoNegocio(New BLL.Distribuidor)
                For Each d In p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = x.ID)

                    desde.Distribuidor = d
                    Dim lf As List(Of BE.Factura) = bf.ObtenerFacturas(desde, hasta).FindAll(Function(z) DirectCast(z, BE.Factura).Distribuidor.ID = d.ID)

                    Dim dr As DataRow = dt.NewRow
                    dr("Distribuidor") = d.Nombre
                    dr("dia01") = IIf(IsNothing(lf.Find(Function(y) y.Fecha.Date = New DateTime(desde.Fecha.Year, desde.Fecha.Month, 1).Date)), " ", "X")
                    dr("dia02") = IIf(IsNothing(lf.Find(Function(y) y.Fecha.Date = New DateTime(desde.Fecha.Year, desde.Fecha.Month, 2).Date)), " ", "X")
                    dr("dia03") = IIf(IsNothing(lf.Find(Function(y) y.Fecha.Date = New DateTime(desde.Fecha.Year, desde.Fecha.Month, 3).Date)), " ", "X")
                    dr("dia04") = " "
                    dr("dia05") = " "
                    dr("dia06") = " "
                    dr("dia07") = " "
                    dr("dia08") = " "
                    dr("dia09") = " "
                    dr("dia10") = " "
                    dr("dia11") = " "
                    dr("dia12") = " "
                    dr("dia13") = " "
                    dr("dia14") = " "
                    dr("dia15") = " "
                    dr("dia16") = " "
                    dr("dia17") = " "
                    dr("dia18") = " "
                    dr("dia19") = " "
                    dr("dia20") = " "
                    dr("dia21") = " "
                    dr("dia22") = " "
                    dr("dia23") = " "
                    dr("dia24") = " "
                    dr("dia25") = " "
                    dr("dia26") = " "
                    dr("dia27") = " "
                    dr("dia28") = " "
                    dr("dia29") = " "
                    dr("dia30") = " "
                    dr("dia31") = " "
                    dt.Rows.Add(dr)
                Next

                grdTransmisioness.DataSource = Nothing
                grdTransmisioness.DataSource = dt
                grdTransmisioness.DataBind()

                If grdTransmisioness.Rows.Count > 0 Then
                    grdTransmisioness.UseAccessibleHeader = True
                    grdTransmisioness.HeaderRow.TableSection = TableRowSection.TableHeader
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
            For Each r As GridViewRow In Me.grdTransmisioness.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdTransmisioness, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdTransmisioness.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdTransmisioness.Rows
                If row.RowIndex = grdTransmisioness.SelectedIndex Then
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


    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick

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


End Class