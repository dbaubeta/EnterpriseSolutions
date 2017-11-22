Imports System.Drawing
Imports System.Globalization


Public Class BitacoraLista
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Try


            If Not IsPostBack Then

                Me.CalendarExtender1.EndDate = Now.Date
                Me.CalendarExtender1.SelectedDate = New Date(Now.Date.Year, Now.Date.Month, 1)
                Me.CalendarExtender2.EndDate = Now.Date
                Me.CalendarExtender2.SelectedDate = Now.Date

                'Me.txtFiltro.Visible = False
                'Me.lblFiltro.Visible = False
            Else
                CalendarExtender1.SelectedDate = DateTime.ParseExact(Me.txtDesde.Text, CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture))
                CalendarExtender2.SelectedDate = DateTime.ParseExact(Me.txthasta.Text, CalendarExtender1.Format, New Globalization.CultureInfo(DirectCast(Session("Idioma"), BE.Idioma).Culture))

            End If







        Catch bex As BE.Excepcion
            Dim bit As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bit.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Private Sub BitacoraLista_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Me.CalendarExtender1.Format = Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern
        Me.CalendarExtender2.Format = Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern
        CargarGrilla()

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Try
            For Each r As GridViewRow In Me.grdBitacora.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer'"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    'r.ToolTip = "Click to select row"
                    'r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdBitacora, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)

        Catch bex As BE.Excepcion
            Dim bit As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bit.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.Bitacora
        Dim bl As New Bitacora.Bitacora
        Dim il As New List(Of BE.Bitacora)
        Dim f As New BLL.Facade_Pantalla
        Dim u As New Seguridad.Usuario

        Try
            Dim dt As DataTable = New DataTable
            dt.Columns.Add("Fecha")
            dt.Columns.Add("Usuario")
            dt.Columns.Add("Modulo")
            dt.Columns.Add("Mensaje")
            dt.Columns.Add("Datos")

            Dim parm1 As New BE.Bitacora
            parm1.FechaHora = Me.CalendarExtender1.SelectedDate
            Dim parm2 As New BE.Bitacora
            parm2.FechaHora = Me.CalendarExtender2.SelectedDate
            parm2.FechaHora = DateAdd(DateInterval.Second, -1, DateAdd(DateInterval.Day, 1, parm2.FechaHora))
            Dim lp As New List(Of BE.Bitacora)
            lp.Add(parm1)
            lp.Add(parm2)

            For Each l As BE.Bitacora In bl.ObtenerEntradas(lp)
                Dim dr As DataRow = dt.NewRow
                dr("Fecha") = l.FechaHora.ToString("yyyy-MM-dd HH:mm:ss")
                u.Usuario.ID = l.IDUsuario
                u.Cargar()
                dr("Usuario") = u.Usuario.Nombre
                dr("Modulo") = l.Modulo
                ' Traducir mensaje
                Dim m As New BE.MensajeError
                m.IDError = l.Mensaje
                dr("Mensaje") = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                dr("Datos") = l.Datos
                dt.Rows.Add(dr)
            Next

            grdBitacora.DataSource = Nothing
            grdBitacora.DataSource = dt
            grdBitacora.DataBind()

            If grdBitacora.Rows.Count > 0 Then
                grdBitacora.UseAccessibleHeader = True
                grdBitacora.HeaderRow.TableSection = TableRowSection.TableHeader
            End If
        Catch bex As BE.Excepcion
            Dim bit As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bit.Guardar(bm)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub


    Private Sub grdBackups_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdBitacora.SelectedIndexChanged
        Try
            For Each row As GridViewRow In grdBitacora.Rows
                If row.RowIndex = grdBitacora.SelectedIndex Then
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                    row.ToolTip = String.Empty
                Else
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                    row.ToolTip = String.Empty
                End If
            Next

        Catch bex As BE.Excepcion
            Dim bit As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bit.Guardar(bm)
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

End Class