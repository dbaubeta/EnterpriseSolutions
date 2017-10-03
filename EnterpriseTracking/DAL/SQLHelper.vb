Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Threading.Tasks
Imports System.Data.SqlClient
Imports System.Data


Public Class SqlHelper

    Private strCon As [String] = My.Resources.StrSql
    Private strConMaster As [String] = My.Resources.StrSqlMaster

#Region "Insert"

    Public Function Insert(Consulta As String, Optional Params As SqlParameter() = Nothing) As Long
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()
        Dim Resultado As Long = 0

        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = Consulta
        If Params IsNot Nothing Then cmd.Parameters.AddRange(Params)
        Try
            con.Open()
            If Consulta.ToUpper.Contains("SELECT SCOPE_IDENTITY()") Then
                Resultado = cmd.ExecuteScalar
            Else
                Resultado = cmd.ExecuteNonQuery()
            End If
            con.Close()
            con.Dispose()
            Return Resultado
        Catch ex As SqlException
            'Dim Log As New Seguridad.Log()
            'Log.Write(ex.Message, ex.StackTrace, "DAL", "Critico")
            Throw ex
        End Try
    End Function
#End Region


#Region "SelectTabla"
    Public Function SelectTabla(Consulta As String, Optional Params As SqlParameter() = Nothing) As DataTable
        Try
            Dim da As New SqlDataAdapter()
            da.SelectCommand = New SqlCommand()
            da.SelectCommand.Connection = New SqlConnection(strCon)
            da.SelectCommand.CommandType = CommandType.Text
            da.SelectCommand.CommandText = Consulta
            If Params IsNot Nothing Then da.SelectCommand.Parameters.AddRange(Params)
            Dim dt As New DataTable()
            da.Fill(dt)
            Return dt
            da.Dispose()
        Catch ex As SqlException
            Throw ex
        End Try
    End Function
#End Region


#Region "SelectEscalar"

    Public Function RetrieveScalar(Consulta As String, Optional Params As SqlParameter() = Nothing) As Integer
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()

        Try
            cmd.Connection = con
            cmd.CommandType = CommandType.Text
            cmd.CommandText = Consulta
            If Params IsNot Nothing Then cmd.Parameters.AddRange(Params)
            con.Open()
            Dim Resultado = cmd.ExecuteScalar()
            con.Close()
            Return CInt(Resultado)

        Catch ex As SqlException
            Throw ex
        End Try
    End Function
#End Region


#Region "Update"

    Public Function Update(Consulta As String, Optional Params As SqlParameter() = Nothing) As Integer
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = Consulta
        If Params IsNot Nothing Then cmd.Parameters.AddRange(Params)
        Try
            con.Open()
            Dim Resultado = cmd.ExecuteNonQuery()
            con.Close()
            con.Dispose()
            Return Resultado
        Catch ex As SqlException
            'Dim Log As New Seguridad.Log()
            'Log.Write(ex.Message, ex.StackTrace, "DAL", "Critico")
            Throw ex
        End Try
    End Function
#End Region


#Region "Delete"

    Public Function Delete(Consulta As String, Optional Params As SqlParameter() = Nothing) As Integer
        Dim con As New SqlConnection(strCon)
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandType = CommandType.Text
        cmd.CommandText = Consulta
        If Params IsNot Nothing Then cmd.Parameters.AddRange(Params)
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

    Public Function CrearParametro(Nombre As String, Value As Long) As SqlParameter
        Dim P As New SqlParameter()
        P.DbType = DbType.Int64
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

    Public Function CrearParametro(Nombre As String, Value As Boolean) As SqlParameter
        Dim P As New SqlParameter()
        P.DbType = DbType.Boolean
        P.ParameterName = Nombre
        P.Value = Value
        Return P
    End Function

#End Region

#Region "Conexiones"

    Public Function ObtenerConexion() As SqlConnection

        Dim cn As New SqlConnection(strCon)
        Return cn

    End Function

    Public Function ObtenerConexionMaster() As SqlConnection

        Dim cn As New SqlConnection(strConMaster)
        Return cn

    End Function

#End Region

End Class


