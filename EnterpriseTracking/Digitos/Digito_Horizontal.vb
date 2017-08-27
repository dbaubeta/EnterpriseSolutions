Imports System.Reflection

Public Class Digito_Horizontal
    Inherits DV

    Public Overrides Sub calcular(o As Object)

        Dim info() As PropertyInfo = o.GetType().GetProperties()
        Dim cadena As String = ""
        For Each i In info.OrderBy(Function(c) c.Name)
            Dim valor As String = i.GetValue(o).ToString
            If i.Name <> "DVH" And valor.Substring(0, IIf(valor.Length >= 18, 18, valor.Length)) <> "System.Collections" Then

                If valor.Substring(0, 3) = "BE." Then
                    Dim x As Object = i.GetValue(o)
                    cadena += x.ID.ToString
                Else
                    cadena += valor
                End If
            End If
        Next
        MsgBox(cadena)


        'valor = 1

    End Sub


End Class
