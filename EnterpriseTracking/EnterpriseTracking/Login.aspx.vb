Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.errmessage.Visible = False
    End Sub


    Protected Sub LogIn(sender As Object, e As EventArgs) Handles btnLogin.Click
        If IsValid Then
            ' Validate the user password
            'IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
            Dim s As New Seguridad.Seguridad
            Dim u As New BE.Usuario
            Dim us As New Seguridad.Usuario
            u.Nombre = Me.txtUsuario.Text

            us = s.ObtenerUsuario(u)
            If us Is Nothing Then
                Me.errmessage.Visible = True
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