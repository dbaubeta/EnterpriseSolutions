Public Class Vendedor

    Dim d As New DAL.Vendedor
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical

    Public Sub Guardar(ob As BE.Secuencia)

        Try
            ' Recalculo todos los digitos verificadores horizontales

            Dim bd As New BLL.Distribuidor
            Dim l As New List(Of BE.ABM)
            l.Add(ob.Distribuidor)
            ob.Distribuidor = bd.ObtenerLista(l)(0)

            For Each v As BE.Vendedor In ob.Lista_Vendedores
                v.DVH = dvh.calcular(v)
                v.Distribuidor.ID = ob.Distribuidor.ID
            Next
            d.Guardar(ob.Lista_Vendedores)
            dvv.tabla = "Vendedor"
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

    Public Function ObtenerVendedores(Optional f As List(Of BE.Vendedor) = Nothing) As List(Of BE.Vendedor)
        Try
            Return d.ObtenerVendedores(f)

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