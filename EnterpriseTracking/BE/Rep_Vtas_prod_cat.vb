	Public Class Rep_Vtas_prod_cat


    Private _Categoria As BE.Categoria
    Private _Producto As BE.Producto

    Public Property Categoria() As BE.Categoria
        Get
            Return _Categoria
        End Get
        Set(ByVal Value As BE.Categoria)
            _Categoria = Value
        End Set
    End Property

    Public Property Producto() As BE.Producto
        Get
            Return _Producto
        End Get
        Set(ByVal Value As BE.Producto)
            _Producto = Value
        End Set
    End Property

    Private _cantidad As Long
    Public Property Cantidad() As Long
        Get
            Return _cantidad
        End Get
        Set(ByVal value As Long)
            _cantidad = value
        End Set
    End Property


    Private _monto As Double
    Public Property monto() As Double
        Get
            Return _monto
        End Get
        Set(ByVal value As Double)
            _monto = value
        End Set
    End Property

    Public Sub New()

        Me.Categoria = New BE.Categoria
        Me.Producto = New BE.Producto

    End Sub


	End Class ' BE.Rep_Vtas_prod_cat