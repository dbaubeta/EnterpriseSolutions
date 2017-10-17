Public Class UsuarioEdicion
    Inherits System.Web.UI.Page

    Dim u As New Seguridad.Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsNothing(Session("Usuario")) Then
            Response.Redirect("~/Login.aspx")
        End If

        Try
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
                    noTranslateUsuarioID.Text = u.Usuario.ID.ToString
                    txtUsuarioNombre.Text = u.Usuario.Nombre
                    dlIdiomas.SelectedValue = u.Usuario.Idioma.ID
                    chkHabilitado.Checked = u.Usuario.Habilitado
                Else
                    noTranslateUsuarioID.Text = 0

                End If

            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

    End Sub

    Private Sub UsuarioEdicion_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Try

            Dim f As New BLL.Facade_Pantalla
            Dim m As New BE.MensajeError

            If Not IsNothing(Session("UsuarioAEditar")) Then
                m.IDError = "tituloEditarUsuario"
            Else
                m.IDError = "tituloNuevoUsuario"
            End If
            lblTitulo.Text = f.ObtenerLeyenda(m, DirectCast(Session("Idioma"), BE.Idioma)).texto_Leyenda

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try
    End Sub

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click

        Dim bit As New Bitacora.Bitacora
        Dim nu As New Seguridad.Usuario
        Dim c As New Cifrado.Cifrado
        Try
            ' Creo un usuario nuevo y lo guardo. Si ya existe se va a actualizar los datos
            If IsNothing(Session("UsuarioAEditar")) Then
                nu.Usuario.ID = 0
            Else
                nu.Usuario.ID = Long.Parse(noTranslateUsuarioID.Text)
            End If
            nu.Usuario.Nombre = txtUsuarioNombre.Text
            nu.Usuario.Idioma.ID = dlIdiomas.SelectedValue
            If txtcontrasena.Text <> "" Then
                nu.Usuario.Password = c.encriptar_md5(txtcontrasena.Text)
            Else
                nu.Usuario.Password = u.Usuario.Password
            End If
            nu.Usuario.Habilitado = chkHabilitado.Checked
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

        Dim erroresval As List(Of BE.MensajeError) = nu.ValidarDatos(nu.Usuario)
        If erroresval.Count > 0 Then
            MostrarMensajeModal(erroresval(0).IDError, True)
        Else
            Dim hayerror As Boolean = False
            Try
                nu.Guardar()
                If IsNothing(Session("UsuarioAEditar")) Then
                    bit.Guardar(New BE.Bitacora("BIT_UsuarioAlta", "Usuario", DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, nu.Usuario.ID.ToString))
                Else
                    bit.Guardar(New BE.Bitacora("BIT_UsuarioModificacion", "Usuario", DirectCast(Session("Usuario"), Seguridad.Usuario).Usuario.ID, nu.Usuario.ID.ToString))
                End If
            Catch bex As BE.Excepcion
                MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
                hayerror = True
            Catch ex As Exception
                MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
                hayerror = True
            End Try
            If Not hayerror Then
                Session("UsuarioAEditar") = Nothing
                Response.Redirect("~/UsuarioLista.aspx")
            End If

        End If

    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click

        MostrarMensajeModal("EstaSeguroSalir", False)

    End Sub

    Private Sub btnModalSi_ServerClick(sender As Object, e As EventArgs) Handles btnModalSi.ServerClick
        Session("UsuarioAEditar") = Nothing
        Response.Redirect("~/UsuarioLista.aspx")
    End Sub

    Private Sub btnModalNo_ServerClick(sender As Object, e As EventArgs) Handles btnModalNo.ServerClick

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