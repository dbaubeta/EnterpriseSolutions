Imports System.Data.SqlClient

Public Class Digito_Vertical
    Inherits DV


    Private _tabla As String
    Public Property tabla() As String
        Get
            Return _tabla
        End Get
        Set(ByVal value As String)
            _tabla = value
        End Set
    End Property


    Public Overrides Function calcular(o As Object) As Long

        ' Calcular el DVH
        Dim dvv As Long = 0
        Try
            Return dvv
        Catch ex As Exception
            Throw ex
        End Try

    End Function


    Public Overloads Function calcular() As Long

        ' Calcular el DVH
        Dim DBH As New DAL.SqlHelper

        Try
            Dim consulta As String = "MERGE INTO DVV " + _
                                      "USING (SELECT '" + Me.tabla + "' as tabla, ISNULL(sum(DVH),0) valor from " + Me.tabla + ") src " + _
                                      "ON src.tabla = DVV.NombreTabla " + _
                                      "WHEN MATCHED THEN " + _
                                      "      UPDATE SET " + _
                                      "          dvv.Valor = src.valor " + _
                                      "WHEN NOT MATCHED THEN " + _
                                      "          INSERT(Nombretabla, valor) " + _
                                      "      VALUES (src.tabla, src.valor);"

            DBH.Insert(consulta)
            Return 0
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
