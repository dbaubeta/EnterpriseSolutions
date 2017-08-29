Imports System.Data.SqlClient
Imports System.Data

Public Class Idioma

    Dim DBH As New SqlHelper


    Public Sub Guardar(ByRef p_idioma As BE.Idioma)

        Dim params(1) As System.Data.SqlClient.SqlParameter

        If IsNothing(p_idioma.ID) Or p_idioma.ID = 0 Then
            ' Insert
            params(0) = DBH.CrearParametro("@P1", p_idioma.Nombre)
            params(1) = DBH.CrearParametro("@P2", Long.Parse(p_idioma.DVH))

            Dim resultado As Long = DBH.Insert("INSERT INTO Idioma(Nombre ,DVH) VALUES(@P1,@P2); SELECT SCOPE_IDENTITY();", params)
            If resultado <> -1 Then
                p_idioma.ID = resultado
            End If
        Else
            ' Update 
            ReDim params(2)
            params(0) = DBH.CrearParametro("@P1", Int32.Parse(p_idioma.ID))
            params(1) = DBH.CrearParametro("@P2", p_idioma.Nombre)
            params(2) = DBH.CrearParametro("@P3", Long.Parse(p_idioma.DVH))

            DBH.Insert("update Idioma set Nombre=@P2, DVH=@P3 where ID=@P1", params)

        End If

        Dim d As New DAL.Leyenda
        d.Guardar_Leyendas(p_idioma)

    End Sub

    Public Function Obtener_Idiomas(i As List(Of BE.Idioma)) As List(Of BE.Idioma)

        Dim params(i.Count - 1) As System.Data.SqlClient.SqlParameter
        Dim cadena As String = "select * from idioma where Id in ("
        Dim idx As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Idioma
        Dim ll As New List(Of BE.Idioma)
        Dim dl As New DAL.Leyenda


        For Each x As BE.Idioma In i
            idx += 1
            If idx > 1 Then cadena += ","
            cadena += "@P" + idx.ToString.Trim
            params(idx - 1) = DBH.CrearParametro("@P" + idx.ToString.Trim, Int32.Parse(x.ID))
        Next
        cadena += ")"

        dt = DBH.SelectTabla(cadena, params)
        For Each dr As DataRow In dt.Rows
            l = New BE.Idioma
            l.ID = dr.Item("ID")
            l.Nombre = dr.Item("Nombre")
            l.DVH = dr.Item("DVH")
            l.Leyendas = dl.ObtenerLeyendas(l)
            ll.Add(l)
        Next

        Return ll

    End Function

End Class
