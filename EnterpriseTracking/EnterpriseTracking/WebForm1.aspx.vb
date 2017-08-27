Public Class WebForm1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
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


        Dim b As New BLL.Leyenda
        Dim l1 As New BE.Leyenda
        Dim l2 As New BE.Leyenda
        Dim i As New BE.Idioma
        Dim m As New BE.MensajeError

        l1.ID = "Idiot"
        l1.texto_Leyenda = "Eres un idiota"
        l1.DVH = 0

        l2.ID = "Saint"
        l2.texto_Leyenda = "Eres un santo"
        l2.DVH = 1

        i.ID = 1
        i.Nombre = "Español"
        i.Leyendas.Add(l1)
        i.Leyendas.Add(l2)

        b.Guardar_Leyendas(i)

    End Sub
End Class