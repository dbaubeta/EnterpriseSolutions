Imports System.Drawing

Public Class GrupoLista
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        CargarGrilla()

        'Me.btnEditarGrupo.Enabled = False
        'Me.btnEliminarGrupo.Enabled = False

    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.Elemento
        Dim bl As New Seguridad.Seguridad
        Dim il As New List(Of BE.Elemento)

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("Nombre")
        dt.Columns.Add("Idioma")
        dt.Columns.Add("Habilitado")

        For Each l As Seguridad.Grupo In bl.ObtenerGrupos()
            Dim dr As DataRow = dt.NewRow
            dr("ID") = l.Elemento.ID
            dr("Nombre") = l.Elemento.nombre
            dt.Rows.Add(dr)
        Next

        grdGrupos.DataSource = Nothing
        grdGrupos.DataSource = dt
        grdGrupos.DataBind()

        grdGrupos.UseAccessibleHeader = True
        grdGrupos.HeaderRow.TableSection = TableRowSection.TableHeader

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        For Each r As GridViewRow In Me.grdGrupos.Rows
            If r.RowType = DataControlRowType.DataRow Then
                r.Attributes("onmouseover") = "this.style.cursor='pointer'"
                r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                r.ToolTip = "Click to select row"
                r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdGrupos, "Select$" + r.RowIndex.ToString, True)
            End If
        Next
        MyBase.Render(writer)

    End Sub

    Private Sub grdGrupos_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdGrupos.SelectedIndexChanged

        'MsgBox(grdGrupos.SelectedRow.Cells(0).Text)
        For Each row As GridViewRow In grdGrupos.Rows
            If row.RowIndex = grdGrupos.SelectedIndex Then
                row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                row.ToolTip = String.Empty
            Else
                row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                row.ToolTip = String.Empty
            End If
        Next
        'If grdGrupos.SelectedRow.Cells(0).Text <> "1" Then
        '    Me.btnEditarGrupo.Enabled = True
        '    Me.btnEliminarGrupo.Enabled = True
        'Else
        '    Me.btnEditarGrupo.Enabled = False
        '    Me.btnEliminarGrupo.Enabled = False
        'End If

    End Sub

    Protected Sub btnNuevoGrupo_Click(sender As Object, e As EventArgs) Handles btnNuevoGrupo.Click
        Session("GrupoAEditar") = Nothing
        Response.Redirect("~/GrupoEdicion.aspx")
    End Sub

    Protected Sub btnEditarGrupo_Click(sender As Object, e As EventArgs) Handles btnEditarGrupo.Click
        If Not IsNothing(grdGrupos.SelectedRow) Then
            Session("GrupoAEditar") = grdGrupos.SelectedRow.Cells(0).Text
            Response.Redirect("~/GrupoEdicion.aspx")
        End If
    End Sub

    Protected Sub btnEliminarGrupo_Click(sender As Object, e As EventArgs) Handles btnEliminarGrupo.Click
        If Not IsNothing(grdGrupos.SelectedRow) Then
            MostrarMensajeModal("EstaSeguroBorrarElementoSeleccionado", False)
        End If
    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick

        'elimino el Grupo
        Dim nu As New Seguridad.Grupo
        nu.Elemento.ID = grdGrupos.SelectedRow.Cells(0).Text
        nu.Eliminar()

        Session("GrupoAEditar") = Nothing
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