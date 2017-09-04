Public Class Enterprise
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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
        Session("Idioma") = l.Find(Function(c) c.ID = dlIdiomas.SelectedValue)
        f.Traducir(Me, DirectCast(Session("Idioma"), BE.Idioma))

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