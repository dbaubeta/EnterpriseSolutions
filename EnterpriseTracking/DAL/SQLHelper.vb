Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Threading.Tasks
Imports System.Data.SqlClient
Imports System.Data


Public Class SqlHelper

    Private strCon As [String] = My.Resources.StrSql

#Region "CRUD"

    Public Function Create(Consulta As String, Params As SqlParameter()) As Integer
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = Consulta
        If Params IsNot Nothing Then
            cmd.Parameters.AddRange(Params)
        End If
        Try
            con.Open()
            Dim Resultado = cmd.ExecuteNonQuery()
            con.Close()
            con.Dispose()
            Return Resultado
        Catch ex As SqlException
            'Dim Log As New Seguridad.Log()
            'Log.Write(ex.Message, ex.StackTrace, "DAL", "Critico")
            Return -1
        End Try
    End Function

    Public Function Retrieve(Consulta As String, Params As SqlParameter()) As DataTable
        Dim da As New SqlDataAdapter()
        da.SelectCommand = New SqlCommand()
        da.SelectCommand.Connection = New SqlConnection(strCon)
        da.SelectCommand.CommandType = CommandType.Text
        da.SelectCommand.CommandText = Consulta
        Dim dt As New DataTable()
        da.Fill(dt)
        Return dt
    End Function
    Public Function RetrieveScalar(Consulta As String, Params As SqlParameter()) As Integer
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = Consulta
        If Params IsNot Nothing Then
            cmd.Parameters.AddRange(Params)
        End If
        con.Open()
        Dim Resultado = cmd.ExecuteScalar()
        con.Close()
        Return CInt(Resultado)
    End Function
    Public Function Update(Consulta As String, Params As SqlParameter()) As Integer
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = Consulta
        If Params IsNot Nothing Then
            cmd.Parameters.AddRange(Params)
        End If
        Try
            con.Open()
            Dim Resultado = cmd.ExecuteNonQuery()
            con.Close()
            con.Dispose()
            Return Resultado
        Catch ex As SqlException
            'Dim Log As New Seguridad.Log()
            'Log.Write(ex.Message, ex.StackTrace, "DAL", "Critico")
            Return -1
        End Try
    End Function
    Public Function Delete(Consulta As String, Params As SqlParameter()) As Integer
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = Consulta
        If Params IsNot Nothing Then
            cmd.Parameters.AddRange(Params)
        End If
        Try
            con.Open()
            Dim Resultado = cmd.ExecuteNonQuery()
            con.Close()
            con.Dispose()
            Return Resultado
        Catch ex As SqlException
            'Dim Log As New Seguridad.Log()
            'Log.Write(ex.Message, ex.StackTrace, "DAL", "Critico")
            Return -1
        End Try
    End Function
#End Region

#Region "Param Builder"
    Public Function CrearParametro(Nombre As String, Value As String) As SqlParameter
        Dim P As New SqlParameter()
        P.DbType = DbType.[String]
        P.ParameterName = Nombre
        P.Value = Value
        Return P
    End Function

    Public Function CrearParametro(Nombre As String, Value As Integer) As SqlParameter
        Dim P As New SqlParameter()
        P.DbType = DbType.Int32
        P.ParameterName = Nombre
        P.Value = Value
        Return P
    End Function

    Public Function CrearParametro(Nombre As String, Value As Single) As SqlParameter
        Dim P As New SqlParameter()
        P.DbType = DbType.[Single]
        P.ParameterName = Nombre
        P.Value = Value
        Return P
    End Function

    Public Function CrearParametro(Nombre As String, Value As DateTime) As SqlParameter
        Dim P As New SqlParameter()
        P.DbType = DbType.DateTime
        P.ParameterName = Nombre
        P.Value = Value
        Return P
    End Function
#End Region


End Class


