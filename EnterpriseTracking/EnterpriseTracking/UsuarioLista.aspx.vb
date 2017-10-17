Imports System.Drawing

Public Class UsuarioLista
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        Try
            CargarGrilla()

            Me.btnEditarUsuario.Enabled = False
            Me.btnEliminarUsuario.Enabled = False
            Me.btnAsignarPermisosUsuario.Enabled = False
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.Usuario
        Dim bl As New Seguridad.Seguridad
        Dim il As New List(Of BE.Usuario)

        Try
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

            If grdUsuarios.Rows.Count > 0 Then
                grdUsuarios.UseAccessibleHeader = True
                grdUsuarios.HeaderRow.TableSection = TableRowSection.TableHeader
            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Try
            For Each r As GridViewRow In Me.grdUsuarios.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdUsuarios, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grdUsuarios_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdUsuarios.SelectedIndexChanged

        Try
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
                Me.btnAsignarPermisosUsuario.Enabled = True
                Me.btnEliminarUsuario.Enabled = True
            Else
                Me.btnEditarUsuario.Enabled = False
                Me.btnAsignarPermisosUsuario.Enabled = False
                Me.btnEliminarUsuario.Enabled = False
            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


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

    Private Sub btnAsignarPermisosUsuario_Click(sender As Object, e As EventArgs) Handles btnAsignarPermisosUsuario.Click

        If Not IsNothing(grdUsuarios.SelectedRow) Then
            Session("UsuarioAEditar") = grdUsuarios.SelectedRow.Cells(0).Text
            Session("EditandoUsuario") = Nothing
            Response.Redirect("~/UsuarioAsignarPermisos.aspx")
        End If
        
    End Sub

    Protected Sub btnEliminarUsuario_Click(sender As Object, e As EventArgs) Handles btnEliminarUsuario.Click

        Try
            If Not IsNothing(grdUsuarios.SelectedRow) Then
                MostrarMensajeModal("EstaSeguroBorrarElementoSeleccionado", False)
            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick

        Dim bit As New Bitacora.Bitacora

        'elimino el usuario
        Try
            Dim nu As New Seguridad.Usuario
            nu.Usuario.ID = grdUsuarios.SelectedRow.Cells(0).Text
            nu.Eliminar()
            bit.Guardar(New BE.Bitacora("BIT_UsuarioEliminacion", "Usuario", DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, nu.Usuario.ID.ToString))

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

        Session("UsuarioAEditar") = Nothing
        Response.Redirect(Request.RawUrl)

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