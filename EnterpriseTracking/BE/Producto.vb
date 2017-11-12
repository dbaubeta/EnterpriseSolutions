
	Public Class Producto
		Inherits ABM


		Private _Categoria As BE.Categoria
		Private _Cliente As BE.Cliente
		Private _ID_Real As String
		Private _Precio As Double
		
		Public Property Categoria() As BE.Categoria
			Get
				Return _Categoria
			End Get
			Set(ByVal Value as BE.Categoria)
				_Categoria = Value
			End Set
		End Property

		Public Property Cliente() As BE.Cliente
			Get
				Return _Cliente
			End Get
			Set(ByVal Value as BE.Cliente)
				_Cliente = Value
			End Set
		End Property

    Public Property IDReal() As Long
        Get
            Return _ID_Real
        End Get
        Set(ByVal Value As Long)
            _ID_Real = Value
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

    Private _stockminimo As Long
    Public Property stockminimo() As Long
        Get
            Return _stockminimo
        End Get
        Set(ByVal value As Long)
            _stockminimo = value
        End Set
    End Property



    Public Sub New()
        Cliente = New BE.Cliente
        Categoria = New BE.Categoria
    End Sub


	End Class

