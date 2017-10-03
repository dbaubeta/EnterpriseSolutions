Imports System.Reflection

Public Class Digito_Horizontal
    Inherits DV

    Public Overrides Function calcular(o As Object) As Long

        Dim info() As PropertyInfo = o.GetType().GetProperties()
        Dim cadena As String = ""

        'Try
        For Each i In info.OrderBy(Function(c) c.Name)

            If Not IsNothing(i.GetValue(o)) Then 'No sumo los campos nulos
                Dim valor As String = i.GetValue(o).ToString
                If i.Name <> "DVH" And i.Name <> "ID" And valor.Substring(0, IIf(valor.Length >= 18, 18, valor.Length)) <> "System.Collections" Then

                    If valor.Substring(0, IIf(valor.Length >= 3, 3, valor.Length)) = "BE." Then
                        Dim x As Object = i.GetValue(o)
                        cadena += x.ID.ToString
                    Else
                        cadena += valor
                    End If
                End If
            End If
        Next

        ' Calcular el DVH
        Dim dvh As Long
        For j As Integer = 0 To cadena.Length - 1
            dvh += Asc(cadena.Substring(j, 1))
        Next

        Return dvh

        'Catch ex As Exception
        ' Throw ex
        'End Try
    End Function


End Class
