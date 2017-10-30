Public Class Factura

	Private _Detalles_Factura As List(Of BE.Detalle_Factura)
	Private _Distribuidor As BE.Distribuidor
    Private _DVH As Long
	Private _Fecha As Date
    Private _ID As Long
	Private _Nro_Factura_Real As String
	Private _PuntoVenta As BE.PuntodeVenta
	Private _Vendedor As BE.Vendedor

	Public Property Detalles_Factura() As List(Of BE.Detalle_Factura)
		Get
            Return _Detalles_Factura
		End Get
		Set(ByVal Value as List(Of BE.Detalle_Factura))
            _Detalles_Factura = Value
		End Set
	End Property

	Public Property Distribuidor() As BE.Distribuidor
		Get
            Return _Distribuidor
		End Get
		Set(ByVal Value as BE.Distribuidor)
            _Distribuidor = Value
		End Set
	End Property

	Public Property DVH() As long
		Get
            Return _DVH
		End Get
		Set(ByVal Value as long)
            _DVH = Value
		End Set
	End Property

	Public Property Fecha() As Date
		Get
            Return _Fecha
		End Get
		Set(ByVal Value as Date)
            _Fecha = Value
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

	Public Property Nro_Factura_Real() As String
		Get
            Return _Nro_Factura_Real
		End Get
		Set(ByVal Value as String)
            _Nro_Factura_Real = Value
		End Set
	End Property

	Public Property PuntoVenta() As BE.PuntodeVenta
		Get
            Return _PuntoVenta
		End Get
		Set(ByVal Value as BE.PuntodeVenta)
            _PuntoVenta = Value
		End Set
	End Property

	Public Property Vendedor() As BE.Vendedor
		Get
            Return _Vendedor
		End Get
		Set(ByVal Value as BE.Vendedor)
            _Vendedor = Value
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

    Public Sub New()
        Me.Detalles_Factura = New List(Of Detalle_Factura)()
        Me.Distribuidor = New BE.Distribuidor
        Me.PuntoVenta = New BE.PuntodeVenta
        Me.Vendedor = New BE.Vendedor

    End Sub


End Class ' BE.Factura
