Public Class UsuarioEdicion
    Inherits System.Web.UI.Page

    Dim u As New Seguridad.Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)
        Dim m As New BE.MensajeError

        If Not IsNothing(Session("UsuarioAEditar")) Then
            u.Usuario.ID = Session("UsuarioAEditar")
            u.Cargar()
        End If
        If Not IsPostBack Then

            l = b.Obtener_Idiomas()

            'Solo cargo la lista si no es postback (por ejemplo cuando cambio el idioma en el dropdwon
            Me.dlIdiomas.DataValueField = "ID"
            Me.dlIdiomas.DataTextField = "Nombre"
            Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
            Me.dlIdiomas.DataBind()
            'dlIdiomas_SelectedIndexChanged(sender, e)
            If Not IsNothing(Session("UsuarioAEditar")) Then
                m.IDError = "tituloEditarUsuario"
                noTranslateUsuarioID.Text = u.Usuario.ID.ToString
                txtUsuarioNombre.Text = u.Usuario.Nombre
                dlIdiomas.SelectedValue = u.Usuario.Idioma.ID
                chkHabilitado.Checked = u.Usuario.Habilitado
            Else
                m.IDError = "tituloNuevoUsuario"
            End If
            lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

        End If

    End Sub

    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

    End Sub

    Private Sub UsuarioEdicion_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender


    End Sub

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim nu As New Seguridad.Usuario
        Dim c As New Cifrado.Cifrado

        ' Creo un usuario nuevo y lo guardo. Si ya existe se va a actualizar los datos
        nu.Usuario.ID = IIf(IsNothing(Session("UsuarioAEditar")), Nothing, Long.Parse(noTranslateUsuarioID.Text))
        nu.Usuario.Nombre = txtUsuarioNombre.Text
        nu.Usuario.Idioma.ID = dlIdiomas.SelectedValue
        If txtContraseña.Text <> "" Then
            nu.Usuario.Password = c.encriptar_md5(txtContraseña.Text)
        Else
            nu.Usuario.Password = u.Usuario.Password
        End If
        nu.Usuario.Habilitado = chkHabilitado.Checked

        nu.Guardar()
        Session("UsuarioAEditar") = Nothing
        Response.Redirect("~/UsuarioLista.aspx")

    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla

        m.IDError = "EstaSeguroSalir"
        noTranslateModalMessage.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModal();", True)



    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session("UsuarioAEditar") = Nothing
        Response.Redirect("~/UsuarioLista.aspx")
    End Sub

    Private Sub btnModalNo_ServerClick(sender As Object, e As EventArgs) Handles btnModalNo.ServerClick
    End Sub
End Class