Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.msjError.Visible = False
    End Sub


    Protected Sub LogIn(sender As Object, e As EventArgs) Handles btnLogin.Click

        Try
            If IsValid Then
                ' Validate the user password
                'IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                Dim s As New Seguridad.Seguridad
                Dim u As New BE.Usuario
                Dim us As New Seguridad.Usuario
                Dim b As New BLL.Facade_Pantalla
                Dim bi As New BLL.Idioma

                u.Nombre = Me.txtUsuario.Text

                us = s.ObtenerUsuario(u)
                Dim em As New BE.MensajeError

                If us Is Nothing Then ' Usuario Inexistente
                    em.IDError = "msjErrorUsuarioIncorrecto"
                ElseIf Not us.ValidarPassword(Me.txtContraseña.Text) Then ' Contraseña incorrecta
                    em.IDError = "msjErrorContraseñaIncorrecta"
                ElseIf us.Usuario.Habilitado = 0 Then ' Usuario Inhabilitado
                    em.IDError = "msjErrorUsuarioInhabilitado"
                Else ' Login correcto
                    Session("Usuario") = us
                    Session("Idioma") = us.Usuario.Idioma
                    Response.Redirect("~/Principal.aspx")
                End If
                Me.msjError.InnerText = b.ObtenerLeyenda(em, Session("Idioma")).texto_Leyenda
                Me.msjError.Visible = True

            End If

        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)

        Try
            l = b.Obtener_Idiomas()

            'Solo cargo la lista si no es postback (por ejemplo cuando cambio el idioma en el dropdwon
            If Not IsPostBack Then
                Me.dlIdiomas.DataValueField = "ID"
                Me.dlIdiomas.DataTextField = "Nombre"
                Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
                Me.dlIdiomas.DataBind()
            End If

            'Traduzco la pagina
            Session("Idioma") = l.Find(Function(c) c.ID = dlIdiomas.SelectedValue)
            f.Traducir(Me, DirectCast(Session("Idioma"), BE.Idioma))
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub


    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

        Dim b As New BE.Idioma
        Dim bl As New BLL.Idioma
        Dim il As New List(Of BE.Idioma)
        Dim f As New BLL.Facade_Pantalla

        Try
            b.ID = dlIdiomas.SelectedValue
            il.Add(b)
            b = bl.Obtener_Idiomas(il)(0)

            f.Traducir(Me, b)
            Session("Idioma") = b
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try
    End Sub


    Private Sub MostrarMensajeModal(Msg As String, simple As Boolean, Optional traducir As Boolean = True)

        Dim m As New BE.MensajeError
        Dim f As New BLL.Facade_Pantalla
        Try
            m.IDError = Msg
            If Not simple Then
                If traducir Then
                    noTranslateModalMessageSiNo.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Else
                    noTranslateModalMessageSiNo.Text = Msg
                End If
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalSiNo();", True)
            Else
                If traducir Then
                    noTranslateModalMessage.Text = f.ObtenerLeyenda(m, Session("Idioma")).texto_Leyenda
                Else
                    noTranslateModalMessage.Text = Msg
                End If
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "openModalOk();", True)
            End If
        Catch bex As BE.Excepcion
            MostrarMensajeModal(bex.Excepcion.Message + Environment.NewLine + bex.Excepcion.StackTrace, True, False)
        Catch ex As Exception
            MostrarMensajeModal(ex.Message + Environment.NewLine + ex.StackTrace, True, False)
        End Try

    End Sub

End Class