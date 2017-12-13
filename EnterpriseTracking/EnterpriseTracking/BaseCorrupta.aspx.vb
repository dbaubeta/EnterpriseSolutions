Public Class _Default
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.LitMensajes.Text = "<p style=""font-size:xx-large;"">La base de datos esta corrupta. Contacte al administrador</p>"

    End Sub

End Class