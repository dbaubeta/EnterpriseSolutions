Imports System.Drawing

Public Class ClienteLista
    Inherits System.Web.UI.Page

    Dim p As New BLL.Persistencia
    Dim strClase As String = "Cliente"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        p.EstablecerObjetoNegocio(New BLL.Cliente)

        Try

            CargarGrilla()

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub CargarGrilla()

        Try
            Dim dt As DataTable = New DataTable
            dt.Columns.Add("ID")
            dt.Columns.Add("Nombre")
            dt.Columns.Add("Provincia")

            For Each l As BE.Cliente In p.ObtenerLista()
                Dim dr As DataRow = dt.NewRow
                dr("ID") = l.ID
                dr("Nombre") = l.Nombre
                dr("Provincia") = l.Provincia.Nombre
                dt.Rows.Add(dr)
            Next

            grdClientes.DataSource = Nothing
            grdClientes.DataSource = dt
            grdClientes.DataBind()

            If grdClientes.Rows.Count > 0 Then
                grdClientes.UseAccessibleHeader = True
                grdClientes.HeaderRow.TableSection = TableRowSection.TableHeader
            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        Try
            For Each r As GridViewRow In Me.grdClientes.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdClientes, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdClientes.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdClientes.Rows
                If row.RowIndex = grdClientes.SelectedIndex Then
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

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevoCliente.Click

        Session(strClase + "AEditar") = Nothing
        Response.Redirect("~/" + strClase + "Edicion.aspx")
    End Sub

    Protected Sub btnEditar_Click(sender As Object, e As EventArgs) Handles btnEditarCliente.Click
        If Not IsNothing(grdClientes.SelectedRow) Then
            Session(strClase + "AEditar") = grdClientes.SelectedRow.Cells(0).Text
            Response.Redirect("~/" + strClase + "Edicion.aspx")
        End If
    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminarCliente.Click

        Try
            If Not IsNothing(grdClientes.SelectedRow) Then
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

        Try
            Dim cl As New BE.Cliente
            Dim li As New List(Of BE.ABM)

            cl.ID = grdClientes.SelectedRow.Cells(0).Text
            li.Add(cl)
            cl = p.ObtenerLista(li)(0)

            p.Eliminar(cl)
            bit.Guardar(New BE.Bitacora("BIT_" + strClase + "Eliminacion", strClase, DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, cl.ID.ToString))

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

        Session(strClase + "AEditar") = Nothing
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