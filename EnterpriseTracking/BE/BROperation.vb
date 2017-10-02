Public Class BROperation


    Private _DVH As Long
    Public Property DVH() As Long
        Get
            Return _DVH
        End Get
        Set(ByVal value As Long)
            _DVH = value
        End Set
    End Property


    Private _Fecha As DateTime
    Public Property Fecha() As DateTime
        Get
            Return _Fecha
        End Get
        Set(ByVal value As DateTime)
            _Fecha = value
        End Set
    End Property

    Private _ID As Long
    Public Property ID() As Long
        Get
            Return _ID
        End Get
        Set(ByVal value As Long)
            _ID = value
        End Set
    End Property

    Private _path As String
    Public Property Path() As String
        Get
            Return _Path
        End Get
        Set(ByVal value As String)
            _Path = value
        End Set
    End Property

    Private _tipo As Integer
    Public Property Tipo() As Integer
        Get
            Return _tipo
        End Get
        Set(ByVal value As Integer)
            _tipo = value
        End Set
    End Property

    Private _borrado As Boolean
    Public Property borrado() As Boolean
        Get
            Return _borrado
        End Get
        Set(ByVal value As Boolean)
            _borrado = value
        End Set
    End Property




End Class
