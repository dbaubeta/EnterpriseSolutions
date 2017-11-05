Public Class Justificacion

    Private _ID As Long
    Public Property ID() As Long
        Get
            Return _ID
        End Get
        Set(ByVal value As Long)
            _ID = value
        End Set
    End Property

    Private _Distribuidor As BE.Distribuidor
    Public Property Distribuidor() As BE.Distribuidor
        Get
            Return _Distribuidor
        End Get
        Set(ByVal value As BE.Distribuidor)
            _Distribuidor = value
        End Set
    End Property

    Private _fecha As Date
    Public Property Fecha() As Date
        Get
            Return _fecha
        End Get
        Set(ByVal value As Date)
            _fecha = value
        End Set
    End Property


    Private _motivo As String
    Public Property Motivo() As String
        Get
            Return _motivo
        End Get
        Set(ByVal value As String)
            _motivo = value
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
        Me.Distribuidor = New BE.Distribuidor
    End Sub


End Class
