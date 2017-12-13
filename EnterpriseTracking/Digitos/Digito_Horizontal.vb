Imports System.Reflection

Public Class Digito_Horizontal
    Inherits DV

    Public Overrides Function calcular(o As Object) As Long

        Dim info() As PropertyInfo = o.GetType().GetProperties()
        Dim cadena As String = ""

        Try
            For Each i In info.OrderBy(Function(c) c.Name)

                If Not IsNothing(i.GetValue(o)) Then 'No sumo los campos nulos

                    Dim t As Type = i.PropertyType
                    Dim valor As String

                    If t.Name = "DateTime" Then
                        Dim dt As Date = i.GetValue(o)
                        valor = dt.ToString("yyyy-MM-dd HH:mm:ss", New Globalization.CultureInfo("en-US"))
                    ElseIf t.Name = "Double" Then
                        Dim dd As Double = i.GetValue(o)
                        valor = dd.ToString(New Globalization.CultureInfo("en-US"))
                    Else
                        valor = i.GetValue(o).ToString()
                    End If
                    If i.Name <> "DVH" And i.Name <> "ID" And i.Name <> "invade" And valor.Substring(0, IIf(valor.Length >= 18, 18, valor.Length)) <> "System.Collections" Then

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

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Function


End Class
