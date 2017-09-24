Imports System.Drawing

Public Class UsuarioLista
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        CargarGrilla()

        Me.btnEditarUsuario.Enabled = False
        Me.btnEliminarUsuario.Enabled = False

    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.Usuario
        Dim bl As New Seguridad.Seguridad
        Dim il As New List(Of BE.Usuario)

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("Nombre")
        dt.Columns.Add("Idioma")
        dt.Columns.Add("Habilitado")

        For Each l As Seguridad.Usuario In bl.ObtenerUsuarios()
            Dim dr As DataRow = dt.NewRow
            dr("ID") = l.Usuario.ID
            dr("Nombre") = l.Usuario.Nombre
            dr("Idioma") = l.Usuario.Idioma.Nombre
            dr("Habilitado") = l.Usuario.Habilitado
            dt.Rows.Add(dr)
        Next

        grdUsuarios.DataSource = Nothing
        grdUsuarios.DataSource = dt
        grdUsuarios.DataBind()

        grdUsuarios.UseAccessibleHeader = True
        grdUsuarios.HeaderRow.TableSection = TableRowSection.TableHeader

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        For Each r As GridViewRow In Me.grdUsuarios.Rows
            If r.RowType = DataControlRowType.DataRow Then
                r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                r.ToolTip = "Click to select row"
                r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdUsuarios, "Select$" + r.RowIndex.ToString, True)
            End If
        Next
        MyBase.Render(writer)

    End Sub

    Private Sub grdUsuarios_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdUsuarios.SelectedIndexChanged

        'MsgBox(grdUsuarios.SelectedRow.Cells(0).Text)
        For Each row As GridViewRow In grdUsuarios.Rows
            If row.RowIndex = grdUsuarios.SelectedIndex Then
                row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                row.ToolTip = String.Empty
            Else
                row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                row.ToolTip = String.Empty
            End If
        Next
        If grdUsuarios.SelectedRow.Cells(0).Text <> "1" Then
            Me.btnEditarUsuario.Enabled = True
            Me.btnEliminarUsuario.Enabled = True
        Else
            Me.btnEditarUsuario.Enabled = False
            Me.btnEliminarUsuario.Enabled = False
        End If

    End Sub

    Protected Sub btnNuevoUsuario_Click(sender As Object, e As EventArgs) Handles btnNuevoUsuario.Click
        Session("UsuarioAEditar") = Nothing
        Response.Redirect("~/UsuarioEdicion.aspx")
    End Sub

    Protected Sub btnEditarUsuario_Click(sender As Object, e As EventArgs) Handles btnEditarUsuario.Click
        If Not IsNothing(grdUsuarios.SelectedRow) Then
            Session("UsuarioAEditar") = grdUsuarios.SelectedRow.Cells(0).Text
            Response.Redirect("~/UsuarioEdicion.aspx")
        End If
    End Sub

    Protected Sub btnEliminarUsuario_Click(sender As Object, e As EventArgs) Handles btnEliminarUsuario.Click
        If Not IsNothing(grdUsuarios.SelectedRow) Then
            MostrarMensajeModal("EstaSeguroBorrarElementoSeleccionado", False)
        End If
    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick

        'elimino el usuario
        Dim nu As New Seguridad.Usuario
        nu.Usuario.ID = grdUsuarios.SelectedRow.Cells(0).Text
        nu.Eliminar()

        Session("UsuarioAEditar") = Nothing
        Response.Redirect(Request.RawUrl)
        'Response.Redirect("~/UsuarioLista.aspx")
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