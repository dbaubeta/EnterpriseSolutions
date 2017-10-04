Public Class Idioma

    Private _ID As Long
    Public Property ID() As Long
        Get
            Return _ID
        End Get
        Set(ByVal value As Long)
            _ID = value
        End Set
    End Property

    Private _Nombre As String
    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal value As String)
            _Nombre = value
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

    Private _Leyendas As List(Of Leyenda)
    Public Property Leyendas() As List(Of Leyenda)
        Get
            Return _Leyendas
        End Get
        Set(ByVal value As List(Of Leyenda))
            _Leyendas = value
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

    Private _cuture As String
    Public Property Culture() As String
        Get
            Return _cuture
        End Get
        Set(ByVal value As String)
            _cuture = value
        End Set
    End Property


    Public Sub New()
        Me.Leyendas = New List(Of BE.Leyenda)
    End Sub

End Class
