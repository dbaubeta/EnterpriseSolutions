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


    Public Sub Guardar()

        Dim d As New DAL.Elemento
        d.Guardar(Me.Elemento)

    End Sub

    Public Sub New()
        Me.Elemento = New BE.Elemento
    End Sub

End Class
