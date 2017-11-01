Public Class MensajeError
    Private _DVH As Long
    Public Property DVH() As Long
        Get
            Return _DVH
        End Get
        Set(ByVal value As Long)
            _DVH = value
        End Set
    End Property


    Private _Id As Long
    Public Property ID() As Long
        Get
            Return _Id
        End Get
        Set(ByVal value As Long)
            _Id = value
        End Set
    End Property

    Private _linea As Long
    Public Property Linea() As Long
        Get
            Return _linea
        End Get
        Set(ByVal value As Long)
            _linea = value
        End Set
    End Property

    Private _mensaje As String
    Public Property Mensaje() As String
        Get
            Return _mensaje
        End Get
        Set(ByVal value As String)
            _mensaje = value
        End Set
    End Property


    Private _IDError As String
    Public Property IDError() As String
        Get
            Return _IDError
        End Get
        Set(ByVal value As String)
            _IDError = value
        End Set
    End Property

    Private _secuencia As BE.Secuencia
    Public Property Secuencia() As BE.Secuencia
        Get
            Return _secuencia
        End Get
        Set(ByVal value As BE.Secuencia)
            _secuencia = value
        End Set
    End Property

    Private _datos As String
    Public Property Datos() As String
        Get
            Return _datos
        End Get
        Set(ByVal value As String)
            _datos = value
        End Set
    End Property



    Public Sub New()

    End Sub
    Public Sub New(p_IDError As String)

        Me.IDError = p_IDError

    End Sub

    Public Sub New(p_IDError As String, p_mensaje As String, Optional p_datos As String = Nothing)

        Me.IDError = p_IDError
        Me.Mensaje = p_mensaje
        Me.Datos = p_datos
    End Sub



End Class
