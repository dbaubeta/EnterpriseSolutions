Imports System.Drawing

Public Class DistribuidorLista
    Inherits System.Web.UI.Page

    Dim p As New BLL.Persistencia
    Dim strClase As String = "Distribuidor"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Dim b As New BLL.Cliente
        p.EstablecerObjetoNegocio(New BLL.Distribuidor)

        Try
            If Not IsPostBack Then

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

            If Not IsNothing(dlClientes.SelectedValue) Then
                x.ID = dlClientes.SelectedValue
                lx.Add(x)
                x = bx.ObtenerLista(lx)(0)

                Dim dt As DataTable = New DataTable
                dt.Columns.Add("ID")
                dt.Columns.Add("Nombre")
                dt.Columns.Add("Provincia")


                For Each l As BE.Distribuidor In p.ObtenerLista().FindAll(Function(z) DirectCast(z, BE.Distribuidor).Cliente.ID = x.ID)
                    Dim dr As DataRow = dt.NewRow
                    dr("ID") = l.ID
                    dr("Nombre") = l.Nombre
                    dr("Provincia") = l.Provincia.Nombre
                    dt.Rows.Add(dr)
                Next

                grdDistribuidors.DataSource = Nothing
                grdDistribuidors.DataSource = dt
                grdDistribuidors.DataBind()

                If grdDistribuidors.Rows.Count > 0 Then
                    grdDistribuidors.UseAccessibleHeader = True
                    grdDistribuidors.HeaderRow.TableSection = TableRowSection.TableHeader
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
            For Each r As GridViewRow In Me.grdDistribuidors.Rows
                If r.RowType = DataControlRowType.DataRow Then
                    r.Attributes("onmouseover") = "this.style.cursor='pointer';this.style.textDecoration='underline';"
                    r.Attributes("onmouseout") = "this.style.textDecoration='none';"
                    r.ToolTip = "Click to select row"
                    r.Attributes("onclick") = Me.Page.ClientScript.GetPostBackClientHyperlink(Me.grdDistribuidors, "Select$" + r.RowIndex.ToString, True)
                End If
            Next
            MyBase.Render(writer)
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try


    End Sub

    Private Sub grd_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grdDistribuidors.SelectedIndexChanged

        Try
            For Each row As GridViewRow In grdDistribuidors.Rows
                If row.RowIndex = grdDistribuidors.SelectedIndex Then
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

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevoDistribuidor.Click
        Dim l As New List(Of BE.ABM)
        Dim x As New BE.Cliente
        Dim hayerror As Boolean
        Dim p2 As New BLL.Persistencia(New BLL.Cliente)

        Try
            If Not IsNothing(dlClientes.SelectedValue) Then
                x.ID = dlClientes.SelectedValue
                l.Add(x)
                Session("ClientePadre") = DirectCast(p2.ObtenerLista(l)(0), BE.Cliente)
                Session(strClase + "AEditar") = Nothing
            End If
        Catch bex As BE.Excepcion
            hayerror = True
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            hayerror = True
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

        If Not hayerror Then Response.Redirect("~/" + strClase + "Edicion.aspx")

    End Sub

    Protected Sub btnEditar_Click(sender As Object, e As EventArgs) Handles btnEditarDistribuidor.Click
        Dim l As New List(Of BE.ABM)
        Dim x As New BE.Cliente
        Dim hayerror As Boolean
        Dim p2 As New BLL.Persistencia(New BLL.Cliente)

        Try
            If Not IsNothing(grdDistribuidors.SelectedRow) Then
                x.ID = dlClientes.SelectedValue
                l.Add(x)
                Session("ClientePadre") = DirectCast(p2.ObtenerLista(l)(0), BE.Cliente)
                Session(strClase + "AEditar") = grdDistribuidors.SelectedRow.Cells(0).Text
            Else
                hayerror = True
            End If
        Catch bex As BE.Excepcion
            hayerror = True
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            hayerror = True
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

        If Not hayerror Then Response.Redirect("~/" + strClase + "Edicion.aspx")


    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminarDistribuidor.Click

        Try
            If Not IsNothing(grdDistribuidors.SelectedRow) Then
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
            Dim cl As New BE.Distribuidor
            Dim li As New List(Of BE.ABM)

            cl.ID = grdDistribuidors.SelectedRow.Cells(0).Text
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