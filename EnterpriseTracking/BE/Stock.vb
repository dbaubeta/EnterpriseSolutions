Public Class Stock

	Private _Cantidad As long
	Private _Distribuidor As BE.Distribuidor
	Private _DVH As long
	Private _Fecha As Date
	Private _ID As Long
	Private _Precio As double
	Private _Producto As BE.Producto
    Private _Tipo As String

	Public Property Cantidad() As long
		Get
			Return _Cantidad
		End Get
		Set(ByVal Value as long)
			_Cantidad = Value
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
		Set(ByVal Value as Long)
            _ID = Value
		End Set
	End Property

	Public Property Precio() As double
		Get
			Return _Precio
		End Get
		Set(ByVal Value as double)
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

	Public Property Tipo() As String
		Get
			Return _Tipo
		End Get
		Set(ByVal Value as String)
			_Tipo = Value
		End Set
	End Property


    Public Sub New()

        Me.Distribuidor = New BE.Distribuidor
        Me.Producto = New BE.Producto

    End Sub

End Class ' BE.Stock
