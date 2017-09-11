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
            u.Nombre = Me.txtUsuario.Text

            us = s.ObtenerUsuario(u)
            If us Is Nothing Then
                Dim em As New BE.MensajeError
                em.IDError = "msjErrorUsuarioIncorrecto"
                Me.msjError.InnerText = b.ObtenerLeyenda(em, Session("Idioma")).texto_Leyenda
                Me.msjError.Visible = True
            Else
                Response.Redirect("~/EditarLenguaje.aspx")
            End If

            'FailureText.Text = "Invalid login attempt"
            'ErrorMessage.Visible = True
        End If
    End Sub


    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

    End Sub
End Class