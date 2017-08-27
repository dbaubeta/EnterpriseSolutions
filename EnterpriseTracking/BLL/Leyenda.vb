Public Class Leyenda

    Public Sub Guardar_Leyendas(i As BE.Idioma)
        Dim l As New DAL.Leyenda
        l.Guardar_Leyendas(i)
    End Sub

    Public Function ObtenerLeyendas(i As BE.Idioma) As List(Of BE.Leyenda)

        Dim l As New DAL.Leyenda
        Return l.ObtenerLeyendas(i)

    End Function

    Public Function ObtenerLeyendas(i As BE.Idioma, m As BE.MensajeError) As BE.Leyenda
        Dim l As New DAL.Leyenda
        Return l.ObtenerLeyendas(i, m)
    End Function



End Class
