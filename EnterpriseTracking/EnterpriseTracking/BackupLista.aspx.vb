Imports System.Drawing
Imports System.Globalization

Public Class BackupLista
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Try

            If Not IsPostBack Then
                Session("AccionBackup") = Nothing
            End If

            CargarGrilla()
        Catch bex As BE.Excepcion
            Dim bit As New Bitacora.Bitacora
            Dim b As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.Nombre, bex.Message)
            bit.Guardar(b)
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.BROperation
        Dim bl As New BLL.BackupRestore
        Dim il As New List(Of BE.BROperation)

        Try
            Dim dt As DataTable = New DataTable
            dt.Columns.Add("Fecha")
            dt.Columns.Add("Path")

            For Each l As BE.BROperation In bl.Obtener_Backups()
                Dim dr As DataRow = dt.NewRow
                dr("Fecha") = l.Fecha.ToString("yyyy-MM-dd HH:mm:ss")
                dr("Path") = l.Path
                dt.Rows.Add(dr)
            Next

            grdBackups.DataSource = Nothing
            grdBackups.DataSource = dt
            grdBackups.DataBind()

            If grdBackups.Rows.Count > 0 Then
                grdBackups.UseAccessibleHeader = True
                grdBackups.HeaderRow.TableSection = TableRowSection.TableHeader
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

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Try
            For Each r As GridViewRow In Me.grdBackups.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer'"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdBackups, "Select$" + r.RowIndex.ToString, True)
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

    Private Sub grdBackups_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdBackups.SelectedIndexChanged
        Try
            For Each row As GridViewRow In grdBackups.Rows
                If row.RowIndex = grdBackups.SelectedIndex Then
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

    Protected Sub btnNuevoBackup_Click(sender As Object, e As EventArgs) Handles btnNuevoBackup.Click
        Session("AccionBackup") = "Crear"
        MostrarMensajeModal("EstaSeguroCrearNuevoBackup", False)
    End Sub

    Protected Sub btnRestore_Click(sender As Object, e As EventArgs) Handles btnRestore.Click
        If Not IsNothing(grdBackups.SelectedRow) Then
            Session("AccionBackup") = "Restaurar"
            MostrarMensajeModal("EstaSeguroRestaurarBackupSeleccionado", False)
        End If
    End Sub

    Protected Sub btnEliminarBackup_Click(sender As Object, e As EventArgs) Handles btnEliminarBackup.Click
        If Not IsNothing(grdBackups.SelectedRow) Then
            Session("AccionBackup") = "Eliminar"
            MostrarMensajeModal("EstaSeguroBorrarBackupSeleccionado", False)
        End If
    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Dim hayerror As Boolean = False

        Try
            Dim x As New BE.BROperation
            Dim d As New BLL.BackupRestore
            Dim bit As New Bitacora.Bitacora

            If Session("AccionBackup") = "Crear" Then
                x.Fecha = Now
                d.Backup(x)
                CargarGrilla()
                bit.Guardar(New BE.Bitacora("BIT_Backup", "Backup", DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID))
                MostrarMensajeModal("BackupCompleto", True)
            End If

            If Session("AccionBackup") = "Restaurar" Then
                x.Fecha = DateTime.ParseExact(grdBackups.SelectedRow.Cells(0).Text.Replace(":", "_"), "yyyy-MM-dd HH_mm_ss", CultureInfo.InvariantCulture)
                d.Restore(x)
                bit.Guardar(New BE.Bitacora("BIT_Restore", "Restore", DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID))
                MostrarMensajeModal("RestoreCompleto", True)

            End If

            If Session("AccionBackup") = "Eliminar" Then
                x.Fecha = DateTime.ParseExact(grdBackups.SelectedRow.Cells(0).Text.Replace(":", "_"), "yyyy-MM-dd HH_mm_ss", CultureInfo.InvariantCulture)
                d.Eliminar(x)
                bit.Guardar(New BE.Bitacora("BIT_Backup", "Backup", DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID))
                CargarGrilla()
            End If

        Catch bex As BE.Excepcion
            Dim bit As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace)
            bit.Guardar(bm)

            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
            hayerror = True
        Catch ex As Exception
            Dim bitac As New Bitacora.Bitacora
            Dim bm As New BE.Bitacora("BIT_ERROR", Me.Page.ToString, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, ex.Message + Environment.NewLine + ex.StackTrace)
            bitac.Guardar(bm)
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
            hayerror = True
        End Try


        If Session("AccionBackup") = "Restaurar" And Not hayerror Then
            Session("AccionBackup") = Nothing
            'Cierro la sesion
            Dim m As Object
            m = Me.Master
            m.Logout()

        Else
            Session("AccionBackup") = Nothing
        End If

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



    Private Sub BackupLista_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

    End Sub
End Class