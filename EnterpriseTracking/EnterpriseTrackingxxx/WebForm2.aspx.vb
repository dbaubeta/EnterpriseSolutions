Public Class WebForm2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim f As New BLL.Facade_Pantalla
        Dim b As New BLL.Idioma
        Dim i As New BE.Idioma
        Dim l As New List(Of BE.Idioma)

        b.Obtener_Idiomas()

        i.ID = 1
        l.Add(i)

        f.Traducir(Me, b.Obtener_Idiomas(l)(0))
    End Sub

    Protected Sub miboton_Click(sender As Object, e As EventArgs) Handles miboton.Click

        'Dim l As New BE.Idioma
        'Dim l1 As New BE.Leyenda
        'Dim l2 As New BE.Leyenda

        'l.ID = "myId"
        'l.Nombre = "MiNombre"
        'l.Leyendas = New List(Of BE.Leyenda)
        'l.pruebita = New BE.Leyenda
        'l.pruebita.ID = 9999

        'l.Leyendas.Add(l1)
        'l.Leyendas.Add(l2)
        'l.DVH.Calcular(l)






    End Sub
End Class