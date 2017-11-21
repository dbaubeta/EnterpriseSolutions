Public Class Secuencia


	Private _Distribuidor As BE.Distribuidor
    Private _DVH As Long
	Private _Estado As String
	Private _Fecha As Date
	Private _Lista_Facturas As List(Of Be.Factura)
	Private _Lista_PDV As List(Of BE.PuntodeVenta)
	Private _Lista_Stock As List(Of BE.Stock)
	Private _Lista_Vendedores As List(Of BE.Vendedor)
    Private _Nro_Secuencia_Real As Long

	Public Property Distribuidor() As BE.Distribuidor
		Get
			Return _Distribuidor
		End Get
		Set(ByVal Value as BE.Distribuidor)
			_Distribuidor = Value
		End Set
	End Property

	Public Property DVH() As Long
		Get
			Return _DVH
		End Get
		Set(ByVal Value as Long)
			_DVH = Value
		End Set
	End Property

	Public Property Estado() As String
		Get
            Return _Estado
		End Get
		Set(ByVal Value as String)
            _Estado = Value
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

	Public Property Lista_Facturas() As List(Of Be.Factura)
		Get
			Return _Lista_Facturas
		End Get
		Set(ByVal Value as List(Of Be.Factura))
			_Lista_Facturas = Value
		End Set
	End Property

	Public Property Lista_PDV() As List(Of BE.PuntodeVenta)
		Get
			Return _Lista_PDV
		End Get
		Set(ByVal Value as List(Of BE.PuntodeVenta))
			_Lista_PDV = Value
		End Set
	End Property

	Public Property Lista_Stock() As List(Of BE.Stock)
		Get
			Return _Lista_Stock
		End Get
		Set(ByVal Value as List(Of BE.Stock))
			_Lista_Stock = Value
		End Set
	End Property

	Public Property Lista_Vendedores() As List(Of BE.Vendedor)
		Get
			Return _Lista_Vendedores
		End Get
		Set(ByVal Value as List(Of BE.Vendedor))
			_Lista_Vendedores = Value
		End Set
	End Property



	Public Property Nro_Secuencia_Real() As Long
		Get
			Return _Nro_Secuencia_Real
		End Get
		Set(ByVal Value as Long)
			_Nro_Secuencia_Real = Value
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


    Public Sub New()

        Me.Fecha = Now()
        Me.Lista_Vendedores = New List(Of BE.Vendedor)
        Me.Lista_Facturas = New List(Of BE.Factura)
        Me.Lista_PDV = New List(Of BE.PuntodeVenta)
        Me.Lista_Stock = New List(Of BE.Stock)
        Me.Distribuidor = New BE.Distribuidor

    End Sub



End Class ' BE.Secuencia


