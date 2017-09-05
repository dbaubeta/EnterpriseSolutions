Public Class home
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.UICulture = "es-AR"
        Me.Culture = "es-AR"
        MyBase.InitializeCulture()

    End Sub

    Private Sub btnEs_Click(sender As Object, e As EventArgs) Handles btnEs.Click
        For Each c As System.Web.UI.Control In Me.Page.Controls
            Me.TraducirControl(c, "Español")
        Next

        Me.UICulture = "es-AR"
        Me.Culture = "es-AR"
        MyBase.InitializeCulture()

    End Sub
    Private Sub btnEn_Click(sender As Object, e As EventArgs) Handles btnEn.Click
        For Each c As System.Web.UI.Control In Me.Page.Controls
            Me.TraducirControl(c, "Ingles")
        Next
        Me.UICulture = "en-US"
        Me.Culture = "en-US"
        MyBase.InitializeCulture()

    End Sub

    Public Sub TraducirControl(ByVal c As System.Web.UI.Control, ByVal texto As String)
        For Each i As System.Web.UI.Control In c.Controls
            If TypeOf i Is ITraducible Then
                DirectCast(i, ITraducible).Traducir(texto)
            End If
            TraducirControl(i, texto)
        Next

    End Sub


End Class