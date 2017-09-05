Public Class Login1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub LogIn(sender As Object, e As EventArgs)
        If IsValid Then
            ' Validate the user password
            'IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
            Response.Redirect("~/EditarLenguaje.aspx")
            'FailureText.Text = "Invalid login attempt"
            'ErrorMessage.Visible = True
        End If
    End Sub

End Class