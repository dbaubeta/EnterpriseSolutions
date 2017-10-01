Imports System.Drawing

Public Class IdiomaLista
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        CargarGrilla()

        'Me.btnEditarIdioma.Enabled = False
        'Me.btnEliminarIdioma.Enabled = False

    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.Idioma
        Dim bl As New BLL.Idioma
        Dim il As New List(Of BE.Idioma)

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("Nombre")
        dt.Columns.Add("Idioma")
        dt.Columns.Add("Habilitado")

        For Each l As BE.Idioma In bl.Obtener_Idiomas()
            Dim dr As DataRow = dt.NewRow
            dr("ID") = l.ID
            dr("Nombre") = l.Nombre
            dt.Rows.Add(dr)
        Next

        grdIdiomas.DataSource = Nothing
        grdIdiomas.DataSource = dt
        grdIdiomas.DataBind()

        grdIdiomas.UseAccessibleHeader = True
        grdIdiomas.HeaderRow.TableSection = TableRowSection.TableHeader

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        For Each r As GridViewRow In Me.grdIdiomas.Rows
            If r.RowType = DataControlRowType.DataRow Then
                r.Attributes("onmouseover") = "this.style.cursor='pointer'"
                r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                r.ToolTip = "Click to select row"
                r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdIdiomas, "Select$" + r.RowIndex.ToString, True)
            End If
        Next
        MyBase.Render(writer)

    End Sub

    Private Sub grdIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdIdiomas.SelectedIndexChanged

        'MsgBox(grdIdiomas.SelectedRow.Cells(0).Text)
        For Each row As GridViewRow In grdIdiomas.Rows
            If row.RowIndex = grdIdiomas.SelectedIndex Then
                row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                row.ToolTip = String.Empty
            Else
                row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                row.ToolTip = String.Empty
            End If
        Next
        'If grdIdiomas.SelectedRow.Cells(0).Text <> "1" Then
        '    Me.btnEditarIdioma.Enabled = True
        '    Me.btnEliminarIdioma.Enabled = True
        'Else
        '    Me.btnEditarIdioma.Enabled = False
        '    Me.btnEliminarIdioma.Enabled = False
        'End If

    End Sub

    Protected Sub btnNuevoIdioma_Click(sender As Object, e As EventArgs) Handles btnNuevoIdioma.Click
        Session("IdiomaAEditar") = Nothing
        Session("EditandoIdioma") = Nothing
        Response.Redirect("~/IdiomaEdicion.aspx")
    End Sub

    Protected Sub btnEditarIdioma_Click(sender As Object, e As EventArgs) Handles btnEditarIdioma.Click
        If Not IsNothing(grdIdiomas.SelectedRow) Then
            Session("IdiomaAEditar") = grdIdiomas.SelectedRow.Cells(0).Text
            Session("EditandoIdioma") = Nothing
            Response.Redirect("~/IdiomaEdicion.aspx")
        End If
    End Sub

    Protected Sub btnEliminarIdioma_Click(sender As Object, e As EventArgs) Handles btnEliminarIdioma.Click
        If Not IsNothing(grdIdiomas.SelectedRow) Then
            MostrarMensajeModal("EstaSeguroBorrarIdiomaSeleccionado", False)
        End If
    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick

        'elimino el Idioma
        Dim ni As New BLL.Idioma
        Dim bi As New BE.Idioma
        Dim li As New List(Of BE.Idioma)
        bi.ID = grdIdiomas.SelectedRow.Cells(0).Text
        li.Add(bi)
        bi = ni.Obtener_Idiomas(li)(0)

        bi.borrado = True
        ni.Guardar(bi)

        Session("IdiomaAEditar") = Nothing
        Response.Redirect(Request.RawUrl)

    End Sub

    Private Sub MostrarMensajeModal(Msg As String, simple As Boolean)

        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla

        m.IDError = Msg
        If Not simple Then
            noTranslateModalMessageSiNo.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalSiNo();", True)
        Else
            noTranslateModalMessage.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalOk();", True)
        End If

    End Sub


End Class