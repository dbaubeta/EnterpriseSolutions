Public Class Leyenda

    Private _ID As String
    Public Property ID() As String
        Get
            Return _ID
        End Get
        Set(ByVal value As String)
            _ID = value
        End Set
    End Property

    Private _Texto_Leyenda As String
    Public Property texto_Leyenda() As String
        Get
            Return _Texto_Leyenda
        End Get
        Set(ByVal value As String)
            _Texto_Leyenda = value
        End Set
    End Property

    Private _DVH As Long
    Public Property DVH() As Long
        Get
            Return _DVH
        End Get
        Set(ByVal value As Long)
            _DVH = value
        End Set
    End Property

    Public Sub New()
    End Sub

End Class
