Public Class Bitacora

    Public Function Cargar(b As BE.Bitacora) As BE.Bitacora
        Dim d As New DAL.Bitacora

        Return d.Cargar(b)
    End Function

    Public Sub Guardar(ByVal b As BE.Bitacora)

        Dim d As New DAL.Bitacora
        Dim dvh As New Digitos.Digito_Horizontal
        Dim dvv As New Digitos.Digito_Vertical

        b.DVH = dvh.calcular(b)
        d.Guardar(b)
    End Sub

    Public Function ObtenerEntradas(f As List(Of BE.Bitacora)) As List(Of BE.Bitacora)
        ObtenerEntradas = Nothing
    End Function

    Public Sub VolcarXML()

    End Sub


End Class
