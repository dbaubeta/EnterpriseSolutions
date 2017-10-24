Public Class Detalle_Factura


	Private _Cantidad As Long
    Private _DVH As Long
	Private _Linea As Long
	Private _Precio As Double
	Private _Producto As BE.Producto

	Public Property Cantidad() As Long
		Get
            Return _Cantidad
		End Get
		Set(ByVal Value as Long)
            _Cantidad = Value
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

	Public Property Linea() As Long
		Get
            Return _Linea
		End Get
		Set(ByVal Value as Long)
            _Linea = Value
		End Set
	End Property

	Public Property Precio() As Double
		Get
            Return _Precio
		End Get
		Set(ByVal Value as Double)
            _Precio = Value
		End Set
	End Property

	Public Property Producto() As BE.Producto
		Get
            Return _Producto
		End Get
		Set(ByVal Value as BE.Producto)
            _Producto = Value
		End Set
	End Property


End Class ' BE.Detalle_Factura
