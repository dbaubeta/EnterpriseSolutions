Public Class PuntodeVenta


	Private _Calle As String
	Private _CodigoPostal As String
	Private _CUIT As Long
	Private _Depto As String
	Private _Distribuidor As BE.Distribuidor
    Private _DVH As Long
	Private _ID As Long
	Private _IDReal As String
	Private _Nombre As String
	Private _Provincia As BE.Provincia
    Private _Vendedor As BE.Vendedor
    Private _borrado As Boolean

	Public Property Calle() As String
		Get
			Return _Calle
		End Get
		Set(ByVal Value as String)
			_Calle = Value
		End Set
	End Property

	Public Property CodigoPostal() As String
		Get
			Return _CodigoPostal
		End Get
		Set(ByVal Value as String)
			_CodigoPostal = Value
		End Set
	End Property

	Public Property CUIT() As Long
		Get
			Return _CUIT
		End Get
		Set(ByVal Value as Long)
			_CUIT = Value
		End Set
	End Property

	Public Property Depto() As String
		Get
			Return _Depto
		End Get
		Set(ByVal Value as String)
			_Depto = Value
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

	Public Property DVH() As Long
		Get
			Return _DVH
		End Get
		Set(ByVal Value as Long)
			_DVH = Value
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

	Public Property IDReal() As String
		Get
            Return _IDReal
		End Get
		Set(ByVal Value as String)
            _IDReal = Value
		End Set
	End Property

	Public Property Nombre() As String
		Get
			Return _Nombre
		End Get
		Set(ByVal Value as String)
			_Nombre = Value
		End Set
	End Property

	Public Property Provincia() As BE.Provincia
		Get
			Return _Provincia
		End Get
		Set(ByVal Value as BE.Provincia)
			_Provincia = Value
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

    Public Property borrado() As Boolean
        Get
            Return _borrado
        End Get
        Set(ByVal value As Boolean)
            _borrado = value
        End Set
    End Property

    Private _numero As Integer
    Public Property numero() As Integer
        Get
            Return _numero
        End Get
        Set(ByVal value As Integer)
            _numero = value
        End Set
    End Property


End Class ' BE.PuntodeVenta
