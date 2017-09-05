Public Class Idioma

    Private pID As Long
    Public Property ID() As Long
        Get
            Return pID
        End Get
        Set(ByVal value As Long)
            pID = value
        End Set
    End Property

    Private p_Nombre As String
    Public Property NewProperty() As String
        Get
            Return p_Nombre
        End Get
        Set(ByVal value As String)
            p_Nombre = value
        End Set
    End Property


End Class
