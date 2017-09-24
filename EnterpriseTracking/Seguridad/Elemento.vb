Public MustInherit Class Elemento

    Private _elemento As BE.Elemento
    Public Property Elemento() As BE.Elemento
        Get
            Return _elemento
        End Get
        Set(ByVal value As BE.Elemento)
            _elemento = value
        End Set
    End Property



    Public MustOverride Sub Cargar()

    Public MustOverride Function ObtenerPermisos() As List(Of Elemento)



End Class
