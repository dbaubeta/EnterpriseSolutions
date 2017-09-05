Public Class Leyenda

    Private pID As String
    Public Property ID() As String
        Get
            Return pID
        End Get
        Set(ByVal value As String)
            pID = value
        End Set
    End Property

    Private pTexto As String
    Public Property Texto() As String
        Get
            Return pTexto
        End Get
        Set(ByVal value As String)
            pTexto = value
        End Set
    End Property



End Class
