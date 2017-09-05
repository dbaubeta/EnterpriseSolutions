Public Class Control
    Private pElemento As Elemento
    Public Property Elemento() As Elemento
        Get
            Return pElemento
        End Get
        Set(ByVal value As Elemento)
            pElemento = value
        End Set
    End Property


    Private pID As String
    Public Property ID() As String
        Get
            Return pID
        End Get
        Set(ByVal value As String)
            pID = value
        End Set
    End Property

    Private pLeyenda As Leyenda
    Public Property Leyenda() As Leyenda
        Get
            Return pLeyenda
        End Get
        Set(ByVal value As Leyenda)
            pLeyenda = value
        End Set
    End Property


End Class
