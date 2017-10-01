Public Class EditarLenguaje
    Inherits System.Web.UI.Page

    Dim u As New BE.Idioma


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

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

    End Sub



    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim falta As Boolean = False
        Dim x As New BE.Idioma
        Dim bi As New BLL.Idioma

        Dim hayerror As Boolean = False
        For Each gvr As GridViewRow In Me.grdLeyendas.Rows
            Dim l As New BE.Leyenda
            If DirectCast(gvr.FindControl("txtNuevoTextoLeyenda"), TextBox).Text = "" Then
                hayerror = True
                Exit For
            End If
        Next

        If hayerror Then
            MostrarMensajeModal("HayLeyendasFaltantes", True)
        Else
            If Not IsNothing(Session("IdiomaAEditar")) Then
                x.ID = Session("IdiomaAEditar")
            End If
            x.Nombre = Me.txtLenguajeNombre.Text
            x.Leyendas = New List(Of BE.Leyenda)
            For Each gvr As GridViewRow In Me.grdLeyendas.Rows
                Dim l As New BE.Leyenda
                l.IDLeyenda = gvr.Cells(0).Text()
                l.texto_Leyenda = DirectCast(gvr.FindControl("txtNuevoTextoLeyenda"), TextBox).Text
                x.Leyendas.Add(l)
            Next

            bi.Guardar(x)

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

        grdLeyendas.UseAccessibleHeader = True
        grdLeyendas.HeaderRow.TableSection = TableRowSection.TableHeader

        If Not IsNothing(Session("IdiomaAEditar")) Then
            cargarIdiomaengrilla()
        End If


    End Sub


    Private Sub cargarIdiomaengrilla()

        Me.txtLenguajeNombre.Text = u.Nombre


        For Each grd As GridViewRow In grdLeyendas.Rows

            Dim o As BE.Leyenda = u.Leyendas.Find(Function(x) x.IDLeyenda = grd.Cells(0).Text)
            If IsNothing(o) Then
                DirectCast(grd.FindControl("txtNuevoTextoLeyenda"), TextBox).Text = ""
            Else
                DirectCast(grd.FindControl("txtNuevoTextoLeyenda"), TextBox).Text = o.texto_Leyenda

            End If
        Next


    End Sub


    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        MostrarMensajeModal("EstaSeguroSalir", False)

    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session("IdiomaAEditar") = Nothing
        Session("EditandoIdioma") = Nothing
        Response.Redirect("~/IdiomaLista.aspx")
    End Sub

    Private Sub btnModalNo_ServerClick(sender As Object, e As EventArgs) Handles btnModalNo.ServerClick

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

    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim f As New BLL.Facade_Pantalla
        Dim m As New BE.MensajeError

        If Not IsNothing(Session("IdiomaAEditar")) Then
            m.IDError = "tituloEditarIdioma"
        Else
            m.IDError = "tituloNuevoIdioma"
        End If
        lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

    End Sub
End Class

