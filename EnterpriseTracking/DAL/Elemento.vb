Public Class Elemento
    Dim DBH As New SqlHelper

    Public Sub AgregarPermiso(ByVal g As BE.Elemento, ByVal p As BE.Elemento, ByVal u As BE.Usuario)

    End Sub

    Public Function Cargar(ByVal e As BE.Elemento) As BE.Elemento
        Cargar = Nothing
    End Function

    Public Sub Guardar(ByVal e As BE.Elemento)

        Dim params(2) As System.Data.SqlClient.SqlParameter

        Try
            ' Insert
            params(0) = DBH.CrearParametro("@P1", e.Descripcion)
            params(1) = DBH.CrearParametro("@P2", Int32.Parse(e.Tipo))
            params(2) = DBH.CrearParametro("@P3", Long.Parse(e.DVH))

            Dim resultado As Long = DBH.Insert("INSERT INTO Elemento(Descripcion, tipo ,DVH) VALUES(@P1,@P2,@P3); SELECT SCOPE_IDENTITY();", params)
            If resultado <> -1 Then
                e.ID = resultado
            End If

        Catch ex As Exception
        End Try
    End Sub

    Public Function ObtenerGrupos(ByVal e As BE.Elemento, ByVal u As BE.Usuario) As List(Of BE.Elemento)
        ObtenerGrupos = Nothing
    End Function

    Public Function ObtenerGrupos() As List(Of BE.Elemento)
        ObtenerGrupos = Nothing
    End Function

    Public Function ObtenerPermisos(ByVal e As BE.Elemento, ByVal u As BE.Usuario) As List(Of BE.Elemento)
        ObtenerPermisos = Nothing
    End Function

    Public Function ObtenerPermisos() As List(Of BE.Elemento)
        ObtenerPermisos = Nothing
    End Function

    Public Sub QuitarPermiso(ByVal g As BE.Elemento, ByVal p As BE.Elemento, ByVal u As BE.Usuario)

    End Sub




End Class
