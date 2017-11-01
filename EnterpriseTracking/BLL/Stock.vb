Public Class Stock

    Dim d As New DAL.Stock
    Dim dvh As New Digitos.Digito_Horizontal
    Dim dvv As New Digitos.Digito_Vertical

    Public Function CalcularStock(l As List(Of BE.Stock)) As List(Of BE.Stock)
        CalcularStock = Nothing
    End Function

    Public Sub Guardar(ob As BE.Secuencia)


        ' Recalculo todos los digitos verificadores horizontales

        Dim bd As New BLL.Distribuidor
        Dim l As New List(Of BE.ABM)

        Try
            l.Add(ob.Distribuidor)
            ob.Distribuidor = bd.ObtenerLista(l)(0)

            For Each v As BE.Stock In ob.Lista_Stock
                ' Recalculo todos los digitos verificadores horizontales
                v.DVH = dvh.calcular(v)
                v.Distribuidor.ID = ob.Distribuidor.ID
            Next
            d.Guardar(ob.Lista_Stock)
            dvv.tabla = "Stock"
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

    Public Function ObtenerStocks(f As List(Of BE.Stock)) As List(Of BE.Stock)
        ObtenerStocks = Nothing
    End Function

    Public Function ValorizarFIFO(l As List(Of BE.Stock)) As List(Of BE.Stock)
        ValorizarFIFO = Nothing
    End Function

    Public Function ValorizarLIFO(l As List(Of BE.Stock)) As List(Of BE.Stock)
        ValorizarLIFO = Nothing
    End Function

    Public Function ValorizarPP(l As List(Of BE.Stock)) As List(Of BE.Stock)
        ValorizarPP = Nothing
    End Function


End Class 