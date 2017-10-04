Imports System.Globalization

Public Class EditarLenguaje
    Inherits System.Web.UI.Page

    Dim u As New BE.Idioma


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If
        Try

            Dim f As New BLL.Facade_Pantalla
            Dim b As New BLL.Idioma
            Dim l As New List(Of BE.Idioma)
            l = b.Obtener_Idiomas()

            If Not IsNothing(Session("EditandoIdioma")) Then
                u = DirectCast(Session("EditandoIdioma"), BE.Idioma)
            End If

            'Solo cargo la lista si no es postback (por ejemplo cuando cambio el idioma en el dropdwon
            If Not IsPostBack Then
                Me.dlIdiomas.DataValueField = "ID"
                Me.dlIdiomas.DataTextField = "Nombre"
                Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
                Me.dlIdiomas.DataBind()
                dlIdiomas_SelectedIndexChanged(sender, e)

                If Not IsNothing(Session("IdiomaAEditar")) Then

                    u.ID = Session("IdiomaAEditar")
                    Dim li As New List(Of BE.Idioma)
                    li.Add(u)
                    u = b.Obtener_Idiomas(li)(0)

                    Session("EditandoIdioma") = u
                    cargarIdiomaengrilla()
                End If

            End If

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub



    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim falta As Boolean = False
        Dim x As New BE.Idioma
        Dim bi As New BLL.Idioma
        Dim hayerror As Boolean = False
        Dim textoerror As String = ""

        Try
            For Each gvr As GridViewRow In Me.grdLeyendas.Rows
                Dim l As New BE.Leyenda
                If DirectCast(gvr.FindControl("txtNuevoTextoLeyenda"), TextBox).Text = "" Then
                    hayerror = True
                    textoerror = "HayLeyendasFaltantes"
                    Exit For
                End If
            Next

            If Not hayerror Then
                Try
                    Dim Culture As CultureInfo = CultureInfo.GetCultureInfo(Me.txtLenguajeCultura.Text)
                Catch
                    hayerror = True
                    textoerror = "CulturaInvalida"
                End Try
            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

        If hayerror Then
            MostrarMensajeModal(textoerror, True)
        Else
            Try
                If Not IsNothing(Session("IdiomaAEditar")) Then
                    x.ID = Session("IdiomaAEditar")
                End If
                x.Nombre = Me.txtLenguajeNombre.Text
                x.Culture = Me.txtLenguajeCultura.Text
                x.Leyendas = New List(Of BE.Leyenda)
                For Each gvr As GridViewRow In Me.grdLeyendas.Rows
                    Dim l As New BE.Leyenda
                    l.IDLeyenda = gvr.Cells(0).Text()
                    l.texto_Leyenda = DirectCast(gvr.FindControl("txtNuevoTextoLeyenda"), TextBox).Text
                    x.Leyendas.Add(l)
                Next

                bi.Guardar(x)

            Catch bex As BE.Excepcion
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
            Catch ex As Exception
                MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
            End Try

            Session("IdiomaAEditar") = Nothing
            Session("EditandoIdioma") = Nothing
            Response.Redirect("~/IdiomaLista.aspx")
        End If



    End Sub

    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

        Dim b As New BE.Idioma
        Dim bl As New BLL.Idioma
        Dim il As New List(Of BE.Idioma)
        Dim f As New BLL.Facade_Pantalla

        Try
            Dim dt As DataTable = New DataTable
            dt.Columns.Add("IDLeyenda")
            dt.Columns.Add("TextoLeyenda")

            b.ID = dlIdiomas.SelectedValue
            il.Add(b)
            Dim i As BE.Idioma = bl.Obtener_Idiomas(il)(0)
            For Each l In i.Leyendas

                Dim dr As DataRow = dt.NewRow
                dr("IDLeyenda") = l.IDLeyenda
                dr("TextoLeyenda") = l.texto_Leyenda
                'dr("NuevoTextoLeyenda") = l.texto_Leyenda
                dt.Rows.Add(dr)
            Next

            grdLeyendas.DataSource = Nothing
            grdLeyendas.DataSource = dt
            grdLeyendas.DataBind()

            If grdLeyendas.Rows.Count > 0 Then
                grdLeyendas.UseAccessibleHeader = True
                grdLeyendas.HeaderRow.TableSection = TableRowSection.TableHeader
            End If
            If Not IsNothing(Session("IdiomaAEditar")) Then
                cargarIdiomaengrilla()
            End If


        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub cargarIdiomaengrilla()

        Try
            Me.txtLenguajeNombre.Text = u.Nombre
            Me.txtLenguajeCultura.Text = u.Culture

            For Each grd As GridViewRow In grdLeyendas.Rows

                Dim o As BE.Leyenda = u.Leyendas.Find(Function(x) x.IDLeyenda = grd.Cells(0).Text)
                If IsNothing(o) Then
                    DirectCast(grd.FindControl("txtNuevoTextoLeyenda"), TextBox).Text = ""
                Else
                    DirectCast(grd.FindControl("txtNuevoTextoLeyenda"), TextBox).Text = o.texto_Leyenda

                End If
            Next


        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        MostrarMensajeModal("EstaSeguroSalir", False)

    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session("IdiomaAEditar") = Nothing
        Session("EditandoIdioma") = Nothing
        Response.Redirect("~/IdiomaLista.aspx")
    End Sub


    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Try
            Dim f As New BLL.Facade_Pantalla
            Dim m As New BE.MensajeError

            If Not IsNothing(Session("IdiomaAEditar")) Then
                m.IDError = "tituloEditarIdioma"
            Else
                m.IDError = "tituloNuevoIdioma"
            End If
            lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
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

