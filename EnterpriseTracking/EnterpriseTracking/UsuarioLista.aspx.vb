Imports System.Drawing

Public Class UsuarioLista
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        CargarGrilla()

    End Sub


    Private Sub CargarGrilla()

        Dim b As New BE.Usuario
        Dim bl As New BLL.Usuario
        Dim il As New List(Of BE.Usuario)

        Dim dt As DataTable = New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("Nombre")
        dt.Columns.Add("Idioma")
        dt.Columns.Add("Habilitado")

        For Each l In bl.ObtenerUsuarios()
            Dim dr As DataRow = dt.NewRow
            dr("ID") = l.ID
            dr("Nombre") = l.Nombre
            dr("Idioma") = l.Idioma.Nombre
            dr("Habilitado") = l.Habilitado
            dt.Rows.Add(dr)
        Next

        grdUsuarios.DataSource = Nothing
        grdUsuarios.DataSource = dt
        grdUsuarios.DataBind()

        grdUsuarios.UseAccessibleHeader = True
        grdUsuarios.HeaderRow.TableSection = TableRowSection.TableHeader

    End Sub



    'Private Sub grdUsuarios_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdUsuarios.RowCreated

    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        e.Row.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
    '        e.Row.Attributes("onmouseout") = "this.style.textDecoration='none';"
    '        e.Row.ToolTip = "Click to select row"
    '        e.Row.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdUsuarios, "Select$" & e.Row.RowIndex)
    '    End If
    'End Sub


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


    End Sub
End Class