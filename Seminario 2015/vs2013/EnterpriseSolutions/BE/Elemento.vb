Public Class Elemento

    Private pID As Long
    Public Property ID() As Long
        Get
            Return pID
        End Get
        Set(ByVal value As Long)
            pID = value
        End Set
    End Property


    Private pDescripcion As String
    Public Property Description() As String
        Get
            Return pDescripcion
        End Get
        Set(ByVal value As String)
            pDescripcion = value
        End Set
    End Property

    
End Class
