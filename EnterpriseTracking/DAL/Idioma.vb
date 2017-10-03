Imports System.Data.SqlClient
Imports System.Data

Public Class Idioma

    Dim DBH As New SqlHelper


    Public Sub Guardar(ByRef p_idioma As BE.Idioma)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            If IsNothing(p_idioma.ID) Or p_idioma.ID = 0 Then
                ' Insert
                params(0) = DBH.CrearParametro("@P1", p_idioma.Nombre)
                params(1) = DBH.CrearParametro("@P2", Long.Parse(p_idioma.DVH))
                params(2) = DBH.CrearParametro("@P3", p_idioma.borrado)

                Dim resultado As Long = DBH.Insert("INSERT INTO Idioma(Nombre ,DVH, borrado) VALUES(@P1,@P2, @P3); SELECT SCOPE_IDENTITY();", params)
                If resultado <> -1 Then
                    p_idioma.ID = resultado
                End If
            Else
                ' Update 
                ReDim params(3)
                params(0) = DBH.CrearParametro("@P1", Int32.Parse(p_idioma.ID))
                params(1) = DBH.CrearParametro("@P2", p_idioma.Nombre)
                params(2) = DBH.CrearParametro("@P3", Long.Parse(p_idioma.DVH))
                params(3) = DBH.CrearParametro("@P4", p_idioma.borrado)

                DBH.Update("update Idioma set Nombre=@P2, DVH=@P3, borrado=@P4 where ID=@P1", params)

            End If

        Catch bex As BE.Excepcion
            Throw bex
        Catch ex As Exception
            Dim bex As New BE.Excepcion
            bex.Excepcion = ex
            bex.Capa = Me.GetType().ToString
            Throw bex
        End Try

    End Sub

    Public Function Obtener_Idiomas(Optional i As List(Of BE.Idioma) = Nothing) As List(Of BE.Idioma)

        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim cadena As String = "select * from idioma where borrado = 0 "
        Dim idx As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Idioma
        Dim ll As New List(Of BE.Idioma)
        Dim dl As New DAL.Leyenda

        Try

            If Not IsNothing(i) Then
                ReDim params(i.Count - 1)

                If i.Count > 0 Then
                    cadena += " and Id in ("

                    For Each x As BE.Idioma In i
                        idx += 1
                        If idx > 1 Then cadena += ","
                        cadena += "@P" + idx.ToString.Trim
                        params(idx - 1) = DBH.CrearParametro("@P" + idx.ToString.Trim, Int32.Parse(x.ID))
                    Next
                    cadena += ")"
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Idioma
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
                l.DVH = dr.Item("DVH")
                l.borrado = dr.Item("borrado")
                l.Leyendas = dl.ObtenerLeyendas(l)
                ll.Add(l)
            Next

            Return ll
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
