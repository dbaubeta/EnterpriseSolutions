Public Class Idioma

    Public Sub Guardar(p_idioma As BE.Idioma)
        Dim d As New DAL.Idioma
        Dim dvh As New Digitos.Digito_Horizontal
        Dim dvv As New Digitos.Digito_Vertical
        Try
            ' Recalculo todos los digitos verificadores horizontales
            p_idioma.DVH = dvh.calcular(p_idioma)

            d.Guardar(p_idioma)
            dvv.tabla = "idioma"
            dvv.calcular()

            Dim l As New BLL.Leyenda
            l.Guardar_Leyendas(p_idioma)


        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Function Obtener_Idiomas(Optional i As List(Of BE.Idioma) = Nothing) As List(Of BE.Idioma)
        Dim d As New DAL.Idioma
        Dim d2 As New DAL.Leyenda
        Dim l As New List(Of BE.Idioma)

        Try
            For Each o In d.Obtener_Idiomas(i)
                o.Leyendas = d2.ObtenerLeyendas(o)
                l.Add(o)
            Next

            Return l
        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

End Class
