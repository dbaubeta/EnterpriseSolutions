Imports System.Drawing
Imports System.Globalization

Public Class BackupLista
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        If Not IsPostBack Then
            Session("AccionBackup") = Nothing
        End If

        CargarGrilla()

    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.BROperation
        Dim bl As New BLL.BackupRestore
        Dim il As New List(Of BE.BROperation)

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

        grdBackups.UseAccessibleHeader = True
        grdBackups.HeaderRow.TableSection = TableRowSection.TableHeader

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        For Each r As GridViewRow In Me.grdBackups.Rows
            If r.RowType = DataControlRowType.DataRow Then
                r.Attributes("onmouseover") = "this.style.cursor='pointer'"
                r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                r.ToolTip = "Click to select row"
                r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdBackups, "Select$" + r.RowIndex.ToString, True)
            End If
        Next
        MyBase.Render(writer)

    End Sub

    Private Sub grdBackups_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdBackups.SelectedIndexChanged

        For Each row As GridViewRow In grdBackups.Rows
            If row.RowIndex = grdBackups.SelectedIndex Then
                row.BackColor = ColorTranslator.FromHtml("#A1DCF2")
                row.ToolTip = String.Empty
            Else
                row.BackColor = ColorTranslator.FromHtml("#FFFFFF")
                row.ToolTip = String.Empty
            End If
        Next

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

        Dim x As New BE.BROperation
        Dim d As New BLL.BackupRestore

        If Session("AccionBackup") = "Crear" Then
            x.Fecha = Now
            d.Backup(x)
            CargarGrilla()
            MostrarMensajeModal("BackupCompleto", True)
        End If

        If Session("AccionBackup") = "Restaurar" Then
            x.Fecha = DateTime.ParseExact(grdBackups.SelectedRow.Cells(0).Text.Replace(":", "_"), "yyyy-MM-dd HH_mm_ss", CultureInfo.InvariantCulture)
            d.Restore(x)
            MostrarMensajeModal("RestoreCompleto", True)
        End If

        If Session("AccionBackup") = "Eliminar" Then
            x.Fecha = DateTime.ParseExact(grdBackups.SelectedRow.Cells(0).Text.Replace(":", "_"), "yyyy-MM-dd HH_mm_ss", CultureInfo.InvariantCulture)
            d.Eliminar(x)
            CargarGrilla()
        End If


        Session("AccionBackup") = Nothing


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