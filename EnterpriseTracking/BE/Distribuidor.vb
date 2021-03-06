Public Class Distribuidor
    Inherits ABM


    Private _cliente As BE.Cliente
    Private _DVH As Long
    Private _IDReal As String
    Private _mail As String
    Private _Provincia As BE.Provincia
    Private _Usuario As BE.Usuario

    Public Property Cliente() As BE.Cliente
        Get
            Return _cliente
        End Get
        Set(ByVal Value As BE.Cliente)
            _cliente = Value
        End Set
    End Property

    Public Property IDReal() As String
        Get
            Return _IDReal
        End Get
        Set(ByVal Value As String)
            _IDReal = Value
        End Set
    End Property

    Public Property Mail() As String
        Get
            Return _mail
        End Get
        Set(ByVal Value As String)
            _mail = Value
        End Set
    End Property

    Public Property Provincia() As BE.Provincia
        Get
            Return _Provincia
        End Get
        Set(ByVal Value As BE.Provincia)
            _Provincia = Value
        End Set
    End Property

    Public Property Usuario() As BE.Usuario
        Get
            Return _Usuario
        End Get
        Set(ByVal Value As BE.Usuario)
            _Usuario = Value
        End Set
    End Property

    Private _diasfactura As String
    Public Property diasfactura() As String
        Get
            Return _diasfactura
        End Get
        Set(ByVal value As String)
            _diasfactura = value
        End Set
    End Property

    Private _AreaVentasCentroLat As Double
    Public Property AreaVentasCentroLat() As Double
        Get
            Return _AreaVentasCentroLat
        End Get
        Set(ByVal value As Double)
            _AreaVentasCentroLat = value
        End Set
    End Property


    Private _AreaVentasCentroLong As Double
    Public Property AreaVentasCentroLong() As Double
        Get
            Return _AreaVentasCentroLong
        End Get
        Set(ByVal value As Double)
            _AreaVentasCentroLong = value
        End Set
    End Property


    Private _AreaVentasRadio As Long
    Public Property AreaVentasRadio() As Long
        Get
            Return _AreaVentasRadio
        End Get
        Set(ByVal value As Long)
            _AreaVentasRadio = value
        End Set
    End Property

    Public Sub New()
        Usuario = New BE.Usuario
        Provincia = New BE.Provincia
        Cliente = New BE.Cliente
    End Sub

End Class

