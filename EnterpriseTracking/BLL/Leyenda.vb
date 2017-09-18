Public Class Leyenda

    Public Sub Guardar_Leyendas(i As BE.Idioma)
        Dim l As New DAL.Leyenda
        Dim dvh As New Digitos.Digito_Horizontal
        Dim dvv As New Digitos.Digito_Vertical
        Try

            ' Recalculo todos los digitos verificadores horizontales
            Dim dvhIdioma As Long = 0
            For j As Integer = 0 To i.ID.ToString.Length - 1
                dvhIdioma += Asc(i.ID.ToString(j))
            Next
            For Each x As BE.Leyenda In i.Leyendas
                x.DVH = dvh.calcular(x) + dvhIdioma
            Next
            ' Guardo en la BD
            l.Guardar_Leyendas(i)

            ' Calculo el Digito verificador vertical
            dvv.tabla = "IdiomaLeyenda"
            dvv.calcular()

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function ObtenerLeyendas(i As BE.Idioma) As List(Of BE.Leyenda)

        Dim l As New DAL.Leyenda
        Try
            Return l.ObtenerLeyendas(i)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerLeyendas(i As BE.Idioma, m As BE.MensajeError) As BE.Leyenda
        Dim l As New DAL.Leyenda
        Try
            Return l.ObtenerLeyendas(i, m)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



End Class
