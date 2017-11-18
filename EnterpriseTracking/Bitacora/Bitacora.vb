Public Class Bitacora

    Public Sub Guardar(ByVal b As BE.Bitacora)

        Dim d As New DAL.Bitacora
        Dim dvh As New Digitos.Digito_Horizontal
        Dim dvv As New Digitos.Digito_Vertical

        b.DVH = dvh.calcular(b)
        d.Guardar(b)
        dvv.tabla = "EntradasBitacora"
        dvv.calcular()

    End Sub

    Public Function ObtenerEntradas(f As List(Of BE.Bitacora)) As List(Of BE.Bitacora)

        Dim d As New DAL.Bitacora
        Return d.ObtenerEntradas(f)

    End Function




End Class
