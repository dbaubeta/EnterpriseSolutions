Public Class Grupo
    Inherits Elemento

    Private _hijos As List(Of Elemento)
    Public Property Hijos() As List(Of Elemento)
        Get
            Return _hijos
        End Get
        Set(ByVal value As List(Of Elemento))
            _hijos = value
        End Set
    End Property

    Public Overrides Function Cargar() As Elemento
        Return Nothing
    End Function

    Public Sub Guardar()

    End Sub


    Public Overrides Function ObtenerPermisos() As List(Of Elemento)
        Dim l As New List(Of Elemento)
        l.Add(Me)

        For Each el As Elemento In Hijos
            l.AddRange(el.ObtenerPermisos)
        Next

        Return l

    End Function
End Class
