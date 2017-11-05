Public Class Justificacion

    Dim d As New DAL.justificacion
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical

    Public Sub Guardar(v As BE.Justificacion)


        Try
            ' Recalculo todos los digitos verificadores horizontales
            v.DVH = dvh.calcular(v)
            d.Guardar(v)
            dvv.tabla = "justificacion"
            ' Recalculo todos los digitos verificadores Verticales
            dvv.calcular()

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub
    Public Sub Eliminar(v As BE.Justificacion)


        Try
            d.Eliminar(v)
            dvv.tabla = "justificacion"
            ' Recalculo todos los digitos verificadores Verticales
            dvv.calcular()

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Function ObtenerJustificaciones(desde As BE.Justificacion, hasta As BE.Justificacion) As List(Of BE.Justificacion)
        Try

            Return d.Obtenerjustificaciones(desde, hasta)

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
