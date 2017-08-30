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


        Dim b As New BLL.Idioma
        Dim l1 As New BE.Leyenda
        Dim l2 As New BE.Leyenda
        Dim i As New BE.Idioma
        Dim m As New BE.MensajeError

        l1.IDLeyenda = "Idiot"
        l1.texto_Leyenda = "shu idiot"
        l1.DVH = 0

        l2.IDLeyenda = "Saint"
        l2.texto_Leyenda = "Shuar a sain"
        l2.DVH = 1

        'i.ID = 2
        i.Nombre = "Ingli"
        i.Leyendas.Add(l1)
        i.Leyendas.Add(l2)

        b.Guardar(i)

    End Sub
End Class