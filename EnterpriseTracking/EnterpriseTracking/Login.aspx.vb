Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.msjError.Visible = False
    End Sub


    Protected Sub LogIn(sender As Object, e As EventArgs) Handles btnLogin.Click
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
            If us Is Nothing Then ' Usuario Inexistente
                Dim em As New BE.MensajeError
                em.IDError = "msjErrorUsuarioIncorrecto"
                Me.msjError.InnerText = b.ObtenerLeyenda(em, Session("Idioma")).texto_Leyenda
                Me.msjError.Visible = True
            ElseIf Not us.ValidarPassword(Me.txtPassword.Text) Then ' Contraseña incorrecta
                Dim em As New BE.MensajeError
                em.IDError = "msjErrorContraseñaIncorrecta"
                Me.msjError.InnerText = b.ObtenerLeyenda(em, Session("Idioma")).texto_Leyenda
                Me.msjError.Visible = True
            Else ' Login correcto
                Session("Usuario") = us
                Session("Idioma") = us.Usuario.Idioma
                Response.Redirect("~/EditarLenguaje.aspx")
            End If

            'FailureText.Text = "Invalid login attempt"
            'ErrorMessage.Visible = True
        End If
    End Sub


    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)
        l = b.Obtener_Idiomas()

        'Solo cargo la lista si no es postback (por ejemplo cuando cambio el idioma en el dropdwon
        If Not IsPostBack Then
            Me.dlIdiomas.DataValueField = "ID"
            Me.dlIdiomas.DataTextField = "Nombre"
            Me.dlIdiomas.DataSource = b.Obtener_Idiomas()
            Me.dlIdiomas.DataBind()
        End If

        'Traduzco la pagina
        'Session("Idioma") = l.Find(Function(c) c.ID = dlIdiomas.SelectedValue)
        f.Traducir(Me, DirectCast(l.Find(Function(c) c.ID = dlIdiomas.SelectedValue), BE.Idioma))

    End Sub


    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

        Dim b As New BE.Idioma
        Dim bl As New BLL.Idioma
        Dim il As New List(Of BE.Idioma)
        Dim f As New BLL.Facade_Pantalla

        b.ID = dlIdiomas.SelectedValue
        il.Add(b)
        b = bl.Obtener_Idiomas(il)(0)

        f.Traducir(Me, b)
        Session("Idioma") = b

    End Sub


End Class