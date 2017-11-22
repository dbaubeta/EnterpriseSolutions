Public Class _Default
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim d As New Digitos.Validador
        Dim li As New List(Of BE.MensajeError)
        Dim f As New BLL.Facade_Pantalla

        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)

        l = b.Obtener_Idiomas()

        'Traduzco la pagina
        li = d.validarDB()
        Dim sb As New StringBuilder
        Dim idi As New BE.Idioma
        idi = l.Find(Function(c) c.ID = 1)
        If li.Count > 0 Then
            Me.LitMensajes.Text = "<p style=""font-size:xx-large;"">La base de datos esta corrupta. Contacte al administrador</p>"
            Session("BaseValidada") = "No"
        Else
            Session("BaseValidada") = "Si"
            Response.Redirect("~/Login.aspx")
        End If



    End Sub

End Class