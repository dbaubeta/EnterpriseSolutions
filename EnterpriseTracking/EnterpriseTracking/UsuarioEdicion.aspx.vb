Public Class UsuarioEdicion
    Inherits System.Web.UI.Page

    Dim u As New Seguridad.Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim l As New List(Of BE.Idioma)


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
            End If

        End If

    End Sub

    Private Sub dlIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlIdiomas.SelectedIndexChanged

    End Sub

    Private Sub UsuarioEdicion_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        If Not IsNothing(Session("UsuarioAEditar")) Then
            Me.noTranslateUsuarioID.Text = u.Usuario.ID.ToString
            Me.txtUsuarioNombre.Text = u.Usuario.Nombre
            Me.dlIdiomas.SelectedValue = u.Usuario.Idioma.ID
        End If

    End Sub
End Class