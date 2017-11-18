Public MustInherit Class ABM

    Private _DVH As Long
    Private _ID As Long
    Private _Nombre As String
    Private _borrado As Boolean


    Public Property DVH() As Long
        Get
            Return _DVH
        End Get
        Set(ByVal Value As Long)
            _DVH = Value
        End Set
    End Property

    Public Property ID() As Long
        Get
            Return _ID
        End Get
        Set(ByVal Value As Long)
            _ID = Value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal Value As String)
            _Nombre = Value
        End Set
    End Property

    Public Property borrado() As Boolean
        Get
            Return _borrado
        End Get
        Set(ByVal value As Boolean)
            _borrado = value
        End Set
    End Property



End Class
