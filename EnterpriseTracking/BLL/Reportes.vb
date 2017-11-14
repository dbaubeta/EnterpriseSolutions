Public Class Reportes

    Dim d As New DAL.Reportes

    Public Function Obtener_Ventas_Dist_Vend(desde As BE.Factura, hasta As BE.Factura) As List(Of BE.Rep_Vtas_Dist_Vend)
        Try

            Return d.Obtener_Ventas_Dist_Vend(desde, hasta)


        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function

    Public Function Obtener_Ventas_Prod_Cat(desde As BE.Factura, hasta As BE.Factura) As List(Of BE.Rep_Vtas_prod_cat)


        Try

            Return d.Obtener_Ventas_Cat_prod(desde, hasta)


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