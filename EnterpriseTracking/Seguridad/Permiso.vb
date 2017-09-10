Public Class Permiso
    Inherits Elemento


    Public Overrides Function Cargar() As Elemento
        Return Nothing
    End Function


    Public Overrides Function ObtenerPermisos() As List(Of Elemento)

        Dim l As New List(Of Elemento)
        l.Add(Me)

        Return l
    End Function

End Class
