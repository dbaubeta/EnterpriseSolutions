Public Class Bitacora


    Private _Datos As String
    Private _DVH As Long
    Private _FechaHora As DateTime
    Private _Mensaje As String
    Private _Modulo As String
    Private _ID As Long
    Private _IDUsuario As Long

    Public Property ID() As Long
        Get
            Return _ID
        End Get
        Set(ByVal value As Long)
            _ID = value
        End Set
    End Property

    Public Property Datos() As String
        Get
            Return _Datos
        End Get
        Set(ByVal Value As String)
            _Datos = Value
        End Set
    End Property

    Public Property DVH() As Long
        Get
            Return _DVH
        End Get
        Set(ByVal Value As Long)
            _DVH = Value
        End Set
    End Property

    Public Property FechaHora() As DateTime
        Get
            Return _FechaHora
        End Get
        Set(ByVal Value As DateTime)
            _FechaHora = Value
        End Set
    End Property

    Public Property Mensaje() As String
        Get
            Return _Mensaje
        End Get
        Set(ByVal Value As String)
            _Mensaje = Value
        End Set
    End Property

    Public Property Modulo() As String
        Get
            Return _Modulo
        End Get
        Set(ByVal Value As String)
            _Modulo = Value
        End Set
    End Property


    Public Property IDUsuario() As Long
        Get
            Return _IDUsuario
        End Get
        Set(ByVal value As Long)
            _IDUsuario = value
        End Set
    End Property

    Public Sub New()

        Me.FechaHora = Now

    End Sub

    Public Sub New(p_Mensaje As String, p_Modulo As String, p_IDUsuario As Long, Optional p_Datos As String = "")

        Me.Mensaje = p_Mensaje
        Me.IDUsuario = p_IDUsuario
        Me.Modulo = p_Modulo
        Me.Datos = p_Datos
        Me.FechaHora = Now

    End Sub

End Class
