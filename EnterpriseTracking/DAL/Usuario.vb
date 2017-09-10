Public Class Usuario

    Dim DBH As New SqlHelper

    Public Sub Agregar_elemento(ByVal p_elemento As BE.Elemento)

    End Sub

    Public Sub Guardar(ByVal u As BE.Usuario)

    End Sub

    Public Function ObtenerUsuarios() As List(Of BE.Usuario)
        ObtenerUsuarios = Nothing
    End Function

    Public Function ObtenerUsuarios(ByVal i As List(Of BE.Usuario)) As List(Of BE.Usuario)


        Dim params() As System.Data.SqlClient.SqlParameter = Nothing
        Dim cadena As String = "select * from usuario"
        Dim idx As Integer = 0
        Dim dt As DataTable
        Dim l As BE.Usuario
        Dim ll As New List(Of BE.Usuario)

        Try

            If Not IsNothing(i) Then
                ReDim params(i.Count - 1)

                If i.Count > 0 Then
                    cadena += " where nombre in ("

                    For Each x As BE.Usuario In i
                        idx += 1
                        If idx > 1 Then cadena += ","
                        cadena += "@P" + idx.ToString.Trim
                        params(idx - 1) = DBH.CrearParametro("@P" + idx.ToString.Trim, x.Nombre)
                    Next
                    cadena += ")"
                End If
            End If


            dt = DBH.SelectTabla(cadena, params)
            For Each dr As DataRow In dt.Rows
                l = New BE.Usuario
                l.ID = dr.Item("ID")
                l.Nombre = dr.Item("Nombre")
                l.DVH = dr.Item("DVH")
                l.Idioma.ID = dr.Item("IDIdioma")
                l.Intentos_fallidos = dr.Item("IntentosFallidos")
                l.Password = dr.Item("password")
                ll.Add(l)
            Next

            Return ll
        Catch ex As Exception
            Throw ex
        End Try





    End Function


End Class
