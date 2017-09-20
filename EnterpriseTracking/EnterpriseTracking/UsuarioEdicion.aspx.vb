Public Class UsuarioEdicion
    Inherits System.Web.UI.Page

    Dim u As New Seguridad.Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)
        Dim m As New BE.MensajeError


        If Not IsPostBack Then

            l = b.Obtener_Idiomas()

            'Solo cargo la lista si no es postback (por ejemplo cuando cambio el idioma en el dropdwon
            Me.dlIdiomas.DataValueField = "ID"
            Me.dlIdiomas.DataTextField = "Nombre"
            Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
            Me.dlIdiomas.DataBind()
            'dlIdiomas_SelectedIndexChanged(sender, e)
            If Not IsNothing(Session("UsuarioAEditar")) Then
                u.Usuario.ID = Session("UsuarioAEditar")
                u.Cargar()
                m.IDError = "tituloEditarUsuario"
                noTranslateUsuarioID.Text = u.Usuario.ID.ToString
                txtUsuarioNombre.Text = u.Usuario.Nombre
                dlIdiomas.SelectedValue = u.Usuario.Idioma.ID
                txtContraseña.Text = "<nochange>"
                chkHabilitado.Value = u.Usuario.Habilitado
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
        If txtContraseña.Text <> "<nochange>" Then
            nu.Usuario.Password = c.encriptar_md5(txtContraseña.Text)
        Else
            nu.Usuario.Password = u.Usuario.Password
        End If
        nu.Usuario.Habilitado = chkHabilitado.Value

        nu.Guardar()


    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModal();", True)

        'Session("UsuarioAEditar") = Nothing
        'Response.Redirect("~/UsuarioEdicion.aspx")

    End Sub
End Class