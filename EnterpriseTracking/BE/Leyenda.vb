Public Class Leyenda

    Private _IDLeyenda As String
    Public Property IDLeyenda() As String
        Get
            Return _IDLeyenda
        End Get
        Set(ByVal value As String)
            _IDLeyenda = value
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
