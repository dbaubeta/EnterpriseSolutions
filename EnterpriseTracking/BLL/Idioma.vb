Public Class Idioma

    Public Sub Guardar(ByVal p_idioma As BE.Idioma)
        Dim d As New DAL.Idioma
        d.Guardar(p_idioma)
    End Sub

    Public Function Obtener_Idiomas(ByVal i As List(Of BE.Idioma)) As List(Of BE.Idioma)
        Dim d As New DAL.Idioma
        Dim d2 As New DAL.Leyenda
        Dim l As New List(Of BE.Idioma)

        For Each o In d.Obtener_Idiomas(i)
            o.Leyendas = d2.ObtenerLeyendas(o)
            l.Add(o)
        Next

        Return l

    End Function

End Class
